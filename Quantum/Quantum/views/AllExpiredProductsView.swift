import SwiftUI


struct AllExpiredProductsView: View {
    let products = ["Onion bag", "Tomato", "Carrot", "Onion bag", "Eggs"]
    
    var body: some View {
        VStack {
            Text("All Expired Products")
                .font(.largeTitle)
                .padding()

            List(products, id: \.self) { product in
                HStack {
                    Image("img1") // Add your image here
                        .resizable()
                        .scaledToFill()
                        .frame(width: 60, height: 60)
                        .clipShape(Circle())
                    Text(product)
                        .font(.headline)
                }
            }
            .padding()
        }
    }
}


#Preview {
    AllExpiredProductsView()
}
