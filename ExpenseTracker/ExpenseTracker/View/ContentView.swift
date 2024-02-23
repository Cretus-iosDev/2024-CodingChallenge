import SwiftUI

struct ContentView: View {
    @StateObject var transactionManager = TransactionManager()

    var body: some View {
        TabView {
            ExpensesView(transactionManager: transactionManager)
                .tabItem {
                    Image(systemName: "chart.bar")
                    Text("Expenses")
                }
            
            AddTransactionView(transactionManager: transactionManager)
                .tabItem {
                    Image(systemName: "plus")
                    Text("Add Transaction")
                }
            
            SettingsView()
                .tabItem {
                    Image(systemName: "gear")
                    Text("Settings")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
