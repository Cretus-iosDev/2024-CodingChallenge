import Foundation

class TransactionManager: ObservableObject {
    @Published var transactions: [Transaction] = []
    
    func addTransaction(_ transaction: Transaction) {
        transactions.append(transaction)
    }
    
   
}
