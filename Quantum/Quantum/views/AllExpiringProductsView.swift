import SwiftUI

struct AllExpiringProductsView: View {
    let products: [Product] = [
        Product(name: "Milk", imageName: "cart", details: "Expires in 3 days"),
        Product(name: "Eggs", imageName: "cart", details: "Expires in 5 days"),
        Product(name: "Cheese", imageName: "cart", details: "Expires in 1 week"),
        Product(name: "Milk", imageName: "cart", details: "Expires in 3 days"),
        Product(name: "Eggs", imageName: "cart", details: "Expires in 5 days"),
        Product(name: "Cheese", imageName: "cart", details: "Expires in 1 week"),
    ]

    var body: some View {
        VStack(alignment: .leading) {
            Text("All Expiring Products")
                .font(.largeTitle)
                .padding()

            List(products) { product in
                ProductRow(product: product)
            }
            .padding()
        }
    }
}

#Preview {
    AllExpiringProductsView()
}
