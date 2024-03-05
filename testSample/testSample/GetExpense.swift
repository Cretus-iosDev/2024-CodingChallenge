//import SwiftUI
//
//struct ExpenseReport: Codable, Identifiable {
//    let id: String
//    let organization: String
//    let submitterId: String
//    let status: String
//    let reason: String
//    let type: String
//    let amount: Int
//    let deductedFromSalary: Bool
//    let billUrl: String
//    let createdDate: String
//    let createdAt: String
//    let updatedAt: String
//    let __v: Int
//
//    enum CodingKeys: String, CodingKey {
//        case id = "_id"
//        case organization, submitterId, status, reason, type, amount, deductedFromSalary, billUrl, createdDate, createdAt, updatedAt, __v
//    }
//}
//
//struct ExpenseResponse: Codable {
//    let message: String
//    let data: [ExpenseReport]
//}
//
//
////import Foundation
//
//class ExpenseViewModel: ObservableObject {
//    @Published var expenseReports: [ExpenseReport] = []
//
//    func fetchExpenseReports() {
//        guard let url = URL(string: "https://dev.slatesy.com/api/expense/employee/?fromCreatedDate=\"2023-01-01\"") else {
//            return
//        }
//
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
//        // Add your token here
//        request.addValue("Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VySWQiOiI2NWUwNTVhOWQwOWFjYWFmM2ViNDE3MmYiLCJlbXBsb3llZUlkIjoiNjVlMDU1YTlkMDlhY2FhZjNlYjQxNzJmIiwiZW1wbG95ZWVEb2N1bWVudElkIjoiNjVlMDU1YTlkMDlhY2FhZjNlYjQxNzMyIiwib3JnYW5pemF0aW9uIjoiNjVkNWVlOWMxNmE2M2RmMzhmNGI0MWFiIiwicGVybWlzc2lvbnMiOnsiQURNSU4iOnsiQUxMIjp0cnVlfX0sImxlZ2FsVW5pdHMiOltdLCJleHAiOjE3NDA3Mzg5ODUsImlhdCI6MTcwOTIwMjk4NX0.P3EUzvpxGshrBbSMi3uIajHVAvJCXNwoy5Bkp1QYrIM", forHTTPHeaderField: "Authorization")
//
//        URLSession.shared.dataTask(with: request) { data, _, error in
//            guard let data = data, error == nil else {
//                print("Error: \(error?.localizedDescription ?? "Unknown error")")
//                return
//            }
//
//            do {
//                let expenseResponse = try JSONDecoder().decode(ExpenseResponse.self, from: data)
//                DispatchQueue.main.async {
//                    self.expenseReports = expenseResponse.data
//                }
//            } catch {
//                print("Error decoding JSON: \(error.localizedDescription)")
//            }
//        }.resume()
//    }
//}
//
//
//
//struct petrolView: View {
//    @ObservedObject var expenseViewModel: ExpenseViewModel
//
//    init(expenseViewModel: ExpenseViewModel) {
//        self.expenseViewModel = expenseViewModel
//        self.expenseViewModel.fetchExpenseReports() // Fetch expense reports when the view is initialized
//    }
//
//    var body: some View {
//        VStack {
//            ForEach(expenseViewModel.expenseReports) { expenseReport in
//                HStack(spacing: 12){
//                  //  Image("petrol")
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text(expenseReport.reason)
//                        Text(expenseReport.type)
//                           // .font(.custom(FontsManager.Poppins.Medium, size: 12)) // Assuming FontsManager is defined
//                    }
//                    Spacer()
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("- Rs. \(expenseReport.amount)")
//                            .foregroundColor(Color(red: 0.99, green: 0.24, blue: 0.29))
//                        Button(action: {
//                            // Action when "View more" is tapped
//                        }) {
//                            Text("View more")
//                        }
//                    }
//                }
//                .padding()
//                .frame(width: 343, height: 84)
//                .background(.white)
//                .cornerRadius(8)
//            }
//        }
//    }
//}
//
//struct foodView: View {
//    @ObservedObject var expenseViewModel: ExpenseViewModel
//
//    init(expenseViewModel: ExpenseViewModel) {
//        self.expenseViewModel = expenseViewModel
//        self.expenseViewModel.fetchExpenseReports() // Fetch expense reports when the view is initialized
//    }
//
//    var body: some View {
//        VStack {
//            ForEach(expenseViewModel.expenseReports) { expenseReport in
//                HStack(spacing: 12){
//                   // Image("food")
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text(expenseReport.reason)
//                        Text(expenseReport.type)
//                    }
//                    Spacer()
//                    VStack(alignment: .leading, spacing: 8) {
//                        Text("- Rs. \(expenseReport.amount)")
//                            .foregroundColor(Color(red: 0.99, green: 0.24, blue: 0.29))
//                        Button(action: {
//                            // Action when "View more" is tapped
//                        }) {
//                            Text("View more")
//                        }
//                    }
//                }
//                .padding()
//                .frame(width: 343, height: 84)
//                .background(.white)
//                .cornerRadius(8)
//            }
//        }
//    }
//}
//
//struct petrolView_Previews: PreviewProvider {
//    static var previews: some View {
//        let expenseViewModel = ExpenseViewModel()
//        return petrolView(expenseViewModel: expenseViewModel)
//            .previewLayout(.fixed(width: 375, height: 200)) // Adjust the preview size as needed
//    }
//}
//
//struct foodView_Previews: PreviewProvider {
//    static var previews: some View {
//        let expenseViewModel = ExpenseViewModel()
//        return foodView(expenseViewModel: expenseViewModel)
//            .previewLayout(.fixed(width: 375, height: 200)) // Adjust the preview size as needed
//    }
//}
//
//struct ExpenseView: View {
//    var body: some View {
//        VStack {
//            petrolView(expenseViewModel: ExpenseViewModel())
//            foodView(expenseViewModel: ExpenseViewModel())
//        }
//    }
//}
