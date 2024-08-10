import SwiftUI

struct ProductRow: View {
    let product: Product

    var body: some View {
        HStack {
            Image("img1")
                .resizable()
                .scaledToFit()
                .frame(width: 100, height: 100)
                .background(Color.gray.opacity(0.2)) 

            VStack(alignment: .leading) {
                Text(product.name)
                    .font(.headline)
                Text(product.details)
                    .font(.subheadline)
                    .foregroundColor(.gray)
            }
            .padding(.leading, 10)

            Spacer()
        }
        .padding()
    }
}


struct Product: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
    let details: String
}
