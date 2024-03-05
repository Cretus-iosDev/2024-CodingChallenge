import SwiftUI

struct ExpenseReport: Codable {
    let organization: String
    let submitterId: String
    let status: String
    let reason: String
    let type: String
    let amount: Int
    let deductedFromSalary: Bool
    let billUrl: String
    let createdDate: String
    let _id: String
    let createdAt: String
    let updatedAt: String
    let __v: Int
}


class CreateExpenseViewModel: ObservableObject {
    @Published var expenseReport: ExpenseReport?
    @Published var errorMessage: String?

    func createExpenseReport(token: String, body: Data) {
        guard let url = URL(string: "https://dev.slatesy.com/api/expense/") else {
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.httpBody = body

        URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                self.errorMessage = error?.localizedDescription
                return
            }

            if let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) {
                do {
                    let createdExpense = try JSONDecoder().decode(ExpenseReport.self, from: data)
                    DispatchQueue.main.async {
                        self.expenseReport = createdExpense
                    }
                } catch {
                    self.errorMessage = "Error decoding JSON: \(error.localizedDescription)"
                }
            } else {
                self.errorMessage = "Failed to create expense report. Status code: \((response as? HTTPURLResponse)?.statusCode ?? -1)"
            }
        }.resume()
    }
}

struct CreateExpenseView: View {
    @StateObject var viewModel = CreateExpenseViewModel()
    @State private var reason = ""
    @State private var type = ""
    @State private var amount = ""
    @State private var selectedDocument: Data?
    @State private var alertItem: AlertItem?

    var body: some View {
        VStack {
            TextField("Reason", text: $reason)
            TextField("Type", text: $type)
            TextField("Amount", text: $amount)

            // Document Uploader
            DocumentUploader(selectedDocument: $selectedDocument)

            Button("Create Expense") {
                guard let amountInt = Int(amount) else {
                    // Handle invalid amount input
                    return
                }
                
                guard let selectedDocument = selectedDocument else {
                    // Handle no document selected
                    return
                }

                let amountString = String(amountInt)
                let bodyDict: [String: Any] = ["reason": reason, "type": type, "amount": amountString]

                do {
                    let body = try JSONSerialization.data(withJSONObject: bodyDict)

                    // Generate S3 Upload URL and upload the document
                    S3Uploader.generateUploadURL(fileData: selectedDocument) { generatedURL in
                        S3Uploader.UploadToS3(generatedURL: generatedURL, fileData: selectedDocument) {
                            // Once document is uploaded to S3, create the expense report
                            viewModel.createExpenseReport(token: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NWUwNTVhOWQwOWFjYWFmM2ViNDE3MmYiLCJlbXBsb3llZUlkIjoiNjVlMDU1YTlkMDlhY2FhZjNlYjQxNzJmIiwiZW1wbG95ZWVEb2N1bWVudElkIjoiNjVlMDU1YTlkMDlhY2FhZjNlYjQxNzMyIiwib3JnYW5pemF0aW9uIjoiNjVkNWVlOWMxNmE2M2RmMzhmNGI0MWFiIiwicGVybWlzc2lvbnMiOnsiQURNSU4iOnsiQUxMIjp0cnVlfX0sImxlZ2FsVW5pdHMiOltdLCJleHAiOjE3NDA3Mzg5ODUsImlhdCI6MTcwOTIwMjk4NX0.P3EUzvpxGshrBbSMi3uIajHVAvJCXNwoy5Bkp1QYrIM", body: body)
                        }
                    }
                } catch {
                    // Handle JSON serialization error
                    print("Error serializing JSON: \(error)")
                }
            }
        }
        .alert(item: $alertItem) { alertItem in
            Alert(title: Text("Error"), message: Text(alertItem.message), dismissButton: .default(Text("OK")))
        }
        .onReceive(viewModel.$errorMessage) { errorMessage in
            if let errorMessage = errorMessage {
                alertItem = AlertItem(message: errorMessage)
            }
        }
        .padding()
    }
}

struct DocumentUploader: View {
    @Binding var selectedDocument: Data?
    @State private var isDocumentPickerPresented: Bool = false

    var body: some View {
        VStack {
            Button("Select Document") {
                isDocumentPickerPresented.toggle()
            }
            .fileImporter(isPresented: $isDocumentPickerPresented, allowedContentTypes: [.pdf, .image]) { result in
                do {
                    let fileURL = try result.get()

                    // Read the contents of the selected file into Data
                    if let fileData = try? Data(contentsOf: fileURL) {
                        selectedDocument = fileData
                    } else {
                        print("Error reading file data")
                    }
                } catch {
                    print("Error importing document: \(error)")
                }
            }

            if let selectedDocument = selectedDocument {
                let megabytes = Double(selectedDocument.count) / (1024 * 1024)
                Text(String(format: "Selected Document: %.1f megabytes", megabytes))
            } else {
                Text("No document selected")
            }
        }
        .padding()
    }
}



struct AlertItem: Identifiable {
    var id = UUID()
    var message: String
}




class S3Uploader {
    
    static func UploadToS3(generatedURL: String, fileData: Data, completion: @escaping () -> Void) {
            // Existing code
        // Set up the URL
        guard let url = URL(string: generatedURL) else {
            print("Invalid URL")
            return
        }
        
        // Create the URL request
        var request = URLRequest(url: url)
        request.httpMethod = "PUT" // Set the request method to PUT
        request.httpBody = fileData // Set the request body to the file data
        
        // Create URLSession
        let session = URLSession.shared
        
        // Create the data task
        let task = session.dataTask(with: request) { data, response, error in
            // Check for errors
            if let error = error {
                print("Error uploading to S3: \(error)")
                return
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                if (200...299).contains(httpResponse.statusCode) {
                    print("Successfully uploaded to S3")
                } else {
                    print("Error uploading to S3. HTTP Status Code: \(httpResponse.statusCode)")
                }
            }
        }
        
        // Start the data task
        task.resume()
    }

    static func generateUploadURL(fileData: Data, completion: @escaping (String) -> Void) {
        let base64EncodedString = fileData.base64EncodedString()
        
        // Construct the boundary string
        let boundary = "Boundary-\(UUID().uuidString)"
        
        // Set up the URL
        guard let url = URL(string: "https://dev.slatesy.com/api/s3/generate-url/image.jpg") else {
            print("Invalid URL")
            return
        }
        
        
        // Create URLSession configuration with extended timeout
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 30 // Set to a higher value as needed

        // Create the URLSession
        let session = URLSession(configuration: configuration)
        
        // Create the URL request
        var request = URLRequest(url: url)
        request.httpMethod = "POST" // Set the request method to POST
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type") // Set the content type to multipart form data
        
        // Add bearer token to the request header
        let bearerToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NWJkZmJiOWI5N2RkMTVlOTg1MGFhNzMiLCJlbXBsb3llZUlkIjoiNjViZGZiYjliOTdkZDE1ZTk4NTBhYTczIiwiZW1wbG95ZWVEb2N1bWVudElkIjoiNjViZGZiYjliOTdkZDE1ZTk4NTBhYTc2Iiwib3JnYW5pemF0aW9uIjoiNjVhYTg2OGRlYzFhNTFkYjk5ZDViMWUyIiwicGVybWlzc2lvbnMiOnsiQURNSU4iOnsiQUxMIjp0cnVlfX0sImxlZ2FsVW5pdHMiOltdLCJleHAiOjE3Mzg0ODU2NjYsImlhdCI6MTcwNjk0OTY2Nn0.Kq1chgotHHkeAm3YR4QkUaLocc23RfjoHC5o61XUB8k"
        request.setValue("Bearer \(bearerToken)", forHTTPHeaderField: "Authorization")
        
        // Construct the request body
        var requestBody = Data()
        let boundaryPrefix = "--\(boundary)\r\n"
        
        requestBody.append(boundaryPrefix.data(using: .utf8)!)
        requestBody.append("Content-Disposition: form-data; name=\"file\"; filename=\"image.jpg\"\r\n".data(using: .utf8)!)
        requestBody.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        requestBody.append(fileData)
        requestBody.append("\r\n".data(using: .utf8)!)
        requestBody.append("--\(boundary)--\r\n".data(using: .utf8)!)
        
        // Set the request body
        request.httpBody = requestBody
        

        // Create the data task
        let task = session.dataTask(with: request) { jsonData, response, error in
            // Check for errors
            if let error = error {
                print("Error fetching data: \(error)")
                return
            }
            
            // Ensure there is data
            guard let data = jsonData else {
                print("No data returned")
                return
            }
            
            // Decode JSON data
            do {
                let decoder = JSONDecoder()
                let responseData = try decoder.decode(UploadURLResponse.self, from: data)
                print("responseData: \(responseData.data)")
                
                // Assuming responseData.data contains the generated URL
                // Upload to S3
                self.UploadToS3(generatedURL: responseData.data, fileData: fileData) {
                    // Code to be executed after the upload to S3 is completed
                    // For example, you can trigger another action or update UI
                }

            } catch let error as DecodingError {
                switch error {
                case .dataCorrupted(let context):
                    print("Data corrupted: \(context)")
                case .keyNotFound(let key, let context):
                    print("Key '\(key)' not found: \(context)")
                case .typeMismatch(let type, let context):
                    print("Type '\(type)' mismatch: \(context)")
                case .valueNotFound(let type, let context):
                    print("Value of type '\(type)' not found: \(context)")
                @unknown default:
                    print("Unknown decoding error")
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }


        }
        
        // Start the data task
        task.resume()
    }

}


struct UploadURLResponse: Codable {
    let message: String
    let data: String
}






