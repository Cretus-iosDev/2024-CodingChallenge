import SwiftUI

struct ExpiredProductsSection: View {
    let products = ["Onion bag", "Tomato", "Carrot", "Onion bag", "Eggs"]

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Expired Products")
                .font(.headline)

            HStack {
                Text("Total Products")
                    .font(.subheadline)
                Text("12")
                    .font(.subheadline)
                    .padding(5)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10)
                Spacer()
                NavigationLink(destination: AllExpiredProductsView()) {
                    Text("View all")
                        .foregroundColor(.green)
                }
            }

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 15) {
                    ForEach(products, id: \.self) { product in
                        VStack {
                            Image("img1") // Add your image here
                                .resizable()
                                .scaledToFill()
                                .frame(width: 60, height: 60)
                                .clipShape(Circle())
                            Text(product)
                                .font(.caption)
                        }
                    }
                }
            }
        }
        //.padding()
    }
}

#Preview {
    ExpiredProductsSection()
}

