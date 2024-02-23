import SwiftUI
import SwiftUICharts


struct ExpensesView: View {
    @ObservedObject var transactionManager: TransactionManager
    @State private var isShowingMonthlyTransactions = false

    var body: some View {
        VStack {
            Text("Expenses Graph")
            
            // Display the graph using SwiftUICharts
            LineView(data: transactionManager.transactions.map { $0.amount }, title: "Expenses", legend: "Last 7 days")
                .padding(.horizontal,12)
                .animation(.easeInOut) // Add animation to the LineView
            
            Text("Last 5 Entries")
                .transition(.opacity) 
            
            // Display last 5 transactions
            List(transactionManager.transactions.prefix(5), id: \.self) { transaction in
                HStack {
                    Text("\(transaction.category):") // Display the name (category)
                        .foregroundColor(.primary)
                    Spacer()
                    Text(formatAmount(transaction.amount)) // Display the formatted amount
                        .foregroundColor(.primary)
                }
            }
            .transition(.scale) // Add scale transition to the list
            
            Button("More Options") {
                // Show all entries month-wise
                withAnimation {
                    isShowingMonthlyTransactions.toggle()
                }
            }
        }
        .animation(.default) // Add default animation to the VStack
        
        .sheet(isPresented: $isShowingMonthlyTransactions) {
                    MonthlyTransactionsView(transactionManager: transactionManager)
                }
    }
    
    // Function to format the amount
    func formatAmount(_ amount: Double) -> String {
        let formattedAmount = String(format: "%.2f", amount) // Format with 2 decimal places
        if formattedAmount.hasSuffix(".00") {
            return String(format: "%.0f", amount) // Remove decimal part if it's .00
        }
        return formattedAmount
    }
}



#Preview {
    ExpensesView(transactionManager: TransactionManager())
}
