

import SwiftUI

struct CartView: View {
    @EnvironmentObject var cart: Cart
    @State private var isCheckoutPresented = false

    var body: some View {
        NavigationView {
            VStack {
                Text("Cart")
                    .font(.title)
                    .padding()
                
                List {
                    ForEach(cart.items) { item in
                        HStack {
                            Text(item.name)
                            Spacer()
                            Text(String(format: "$%.2f", item.price))
                        }
                    }
                }
                
                Text("Total: $\(String(format: "%.2f", cart.totalPrice))")
                    .font(.headline)
                    .padding(.top, 10)
                
                NavigationLink(destination: ContentView(), isActive: $isCheckoutPresented) {
                    EmptyView()
                }
                
                Button(action: {
                    isCheckoutPresented = true
                }) {
                    Text("Checkout")
                        .padding()
                        .foregroundColor(.white)
                        .background(Color.blue)
                        .cornerRadius(8)
                }
                .padding()
            }
            .navigationBarTitle("Cart")
        }
    }
}



struct CartView_Previews: PreviewProvider {
    static var previews: some View {
        let cart = Cart()
        cart.addItem(Item(id: 1, name: "Item 1", icon: "icon1", price: 9.99))
        cart.addItem(Item(id: 2, name: "Item 2", icon: "icon2", price: 14.99))
        
        return CartView()
            .environmentObject(cart)
    }
}

