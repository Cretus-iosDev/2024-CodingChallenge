import SwiftUI

struct MonthlyTransactionsView: View {
    @ObservedObject var transactionManager: TransactionManager
    
    var body: some View {
        List(transactionManager.transactions, id: \.id) { transaction in
            VStack(alignment: .leading) {
                Text("Category: \(transaction.category)")
                Text("Amount: \(transaction.amount)")
                Text("Date: \(transaction.date)")
            }
        }
    }
}

struct MonthlyTransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        let transactionManager = TransactionManager()
        transactionManager.transactions = [
            Transaction(amount: 100, date: Date(), category: "Food"),
            Transaction(amount: 150, date: Date().addingTimeInterval(-86400), category: "Transport"),
            Transaction(amount: 200, date: Date().addingTimeInterval(-2 * 86400), category: "Shopping"),
            Transaction(amount: 75, date: Date().addingTimeInterval(-3 * 86400), category: "Entertainment"),
            Transaction(amount: 120, date: Date().addingTimeInterval(-4 * 86400), category: "Groceries")
        ]
        
        return MonthlyTransactionsView(transactionManager: transactionManager)
    }
}

