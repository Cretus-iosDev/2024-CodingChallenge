import SwiftUI

struct HouseTabView: View {
    var body: some View {
        NavigationView {
            ScrollView {
                VStack {
                    HeaderView()
                    OfferBannerView()
                    GroceryBudgetView(monthlyBudget: 39)
                    ExpiredProductsSection()
                    ExpiringSoonSection()
                }
                .padding()
                .background(Color.white.ignoresSafeArea())
            }
        }
    }
}

#Preview {
    HouseTabView()
}
