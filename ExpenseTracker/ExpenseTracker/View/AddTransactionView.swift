import SwiftUI

struct AddTransactionView: View {
    @ObservedObject var transactionManager: TransactionManager
    @State private var amount = ""
    @State private var date = Date()
    @State private var category = ""
    
    var body: some View {
        VStack {
            TextField("Amount", text: $amount)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            DatePicker("Date", selection: $date, displayedComponents: .date)
                .padding()
            
            TextField("Category", text: $category)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()
            
            Button("Add Transaction") {
                if let amount = Double(amount) {
                    let transaction = Transaction(amount: amount, date: date, category: category)
                    transactionManager.addTransaction(transaction)
                    // Clear fields after adding transaction
                    self.amount = ""
                    self.category = ""
                }
            }
            .padding()
        }
    }
}



#Preview {
    AddTransactionView(transactionManager: TransactionManager())
}
