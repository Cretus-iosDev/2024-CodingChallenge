//import SwiftUI
//
//struct ExpenseReport: Codable {
//    let _id: String
//    let organizationId: String
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
//    let approverId: String
//    let updatedDate: String
//}
//
//struct ExpenseResponse: Codable {
//    let message: String
//    let data: ExpenseReport
//}
//
//class ExpenseDetailViewModel: ObservableObject {
//    @Published var expenseReport: ExpenseReport?
//
//    func fetchExpenseReport() {
//        guard let url = URL(string: "https://dev.slatesy.com/api/expense/65e019f8d09acaaf3eb412c4") else {
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
//                    self.expenseReport = expenseResponse.data
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
//struct FoodExpenses: View {
//    @StateObject var viewModel = ExpenseDetailViewModel()
//    
//    // MARK: dateFormatter
//    let dateFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
//        formatter.timeZone = TimeZone(abbreviation: "UTC") // Set the timezone to UTC
//        return formatter
//    }()
//    
//    // MARK: dateOnlyFormatter
//    let dateOnlyFormatter: DateFormatter = {
//        let formatter = DateFormatter()
//        formatter.dateFormat = "yyyy-MM-dd" // Adjust the format to your needs
//        formatter.timeZone = TimeZone(abbreviation: "IST") // Set the timezone to IST
//        return formatter
//    }()
//    
//    var body: some View {
//        NavigationView {
//            VStack(spacing: 16) {
//                HStack(spacing: 160) {
//                    Text("Food Expenses")
//                      //  .font(.custom(FontsManager.Poppins.Medium, size: 16))
//                        .foregroundColor(.primary)
//                    Button {
//                        // Action for the button
//                    } label: {
//                        Image(systemName: "x.circle")
//                            .foregroundColor(.gray)
//                    }
//                }
//                .padding(.horizontal, 22)
//                
//                if let expenseReport = viewModel.expenseReport {
//                    HStack {
//                        Text("Date")
//                         //   .font(.custom(FontsManager.Poppins.Medium, size: 14))
//                            .foregroundColor(.primary)
//                        Spacer()
//                        if let createdDate = dateFormatter.date(from: expenseReport.createdDate) {
//                            let istDate = convertToIST(date: createdDate)
//                            Text(dateOnlyFormatter.string(from: istDate))
//                                .foregroundColor(.primary)
//                        } else {
//                            Text("Invalid Date")
//                                .foregroundColor(.red) // Handle invalid date gracefully
//                        }
//                    }
//                    .padding(.horizontal, 25)
//                    
//                    HStack {
//                        Text("EMP")
//                          //  .font(.custom(FontsManager.Poppins.Medium, size: 14))
//                            .foregroundColor(.primary)
//                        Spacer()
//                        Text(expenseReport.submitterId) // Replace with the appropriate submitter ID field from the expense report
//                            .foregroundColor(.primary)
//                    }
//                    .padding(.horizontal, 25)
//                    
//                    HStack {
//                        Text("Status")
////                            .font(.custom(FontsManager.Poppins.Medium, size: 14))
////                            .font(.custom(FontsManager.Poppins.Medium, size: 14))
//                            .foregroundColor(.primary)
//                        Spacer()
//                        Button(action: {}) {
//                            Text(expenseReport.status)
//                                .foregroundColor(.white)
//                        }
//                        .frame(width: 81, height: 26)
//                        .background(expenseReport.status == "approved" ? Color.green : Color(red: 1, green: 0.66, blue: 0))
//                        .cornerRadius(4)
//                    }
//                    .padding(.horizontal, 25)
//                    
//                    HStack {
//                        Text("Amount")
//                           // .font(.custom(FontsManager.Poppins.Medium, size: 14))
//                            .foregroundColor(.primary)
//                        Spacer()
//                        Text("₹ \(expenseReport.amount)") // Replace with the appropriate amount field from the expense report
//                            .foregroundColor(.primary)
//                    }
//                    .padding(.horizontal, 25)
//                } else {
//                    ProgressView()
//                }
//                
//                ZStack {
//                    Rectangle()
//                        .stroke(style: StrokeStyle(lineWidth: 1, dash: [5]))
//                        .frame(width: 293, height: 133)
//                        .aspectRatio(contentMode: .fit)
//                    
//                    VStack(spacing: 8) {
//                        Image("document-upload")
//                        
//                        HStack {
//                            Button {} label: {
//                                Text("Click to View")
//                              //      .font(.custom(FontsManager.Poppins.Medium, size: 14))
//                            }
//                            Text("or drag and drop")
//                            //    .font(.custom(FontsManager.Poppins.Medium, size: 14))
//                                .foregroundColor(Color(red: 0.21, green: 0.21, blue: 0.21))
//                        }
//                        
//                        Text(" (Max. File size: 25 MB)")
//                        //    .font(.custom(FontsManager.Poppins.Medium, size: 14))
//                    }
//                }
//                .frame(width: 343, height: 133)
//            }
//            .frame(width: 343, height: 370)
//            .background(.white)
//            .cornerRadius(24)
//            .shadow(color: Color(red: 0, green: 0, blue: 0, opacity: 0.34), radius: 40, y: 11)
//            .onAppear {
//                viewModel.fetchExpenseReport()
//            }
//        }
//        .navigationBarBackButtonHidden(true)
//        
//    }
//    
//    //MARK: FUNC. FOR convertToIST
//    func convertToIST(date: Date) -> Date {
//        let calendar = Calendar.current
//        let utcOffset = 5.5 // IST is UTC +5:30
//
//        var components = DateComponents()
//        components.hour = Int(utcOffset)
//        components.minute = Int((utcOffset - floor(utcOffset)) * 60)
//
//        return calendar.date(byAdding: components, to: date) ?? date
//    }
//}
//
//#Preview {
//    FoodExpenses()
//}
//
