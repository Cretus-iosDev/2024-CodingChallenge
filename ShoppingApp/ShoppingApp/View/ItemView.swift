import SwiftUI

struct ItemView: View {
    let item: Item
    @EnvironmentObject var cart: Cart
    @EnvironmentObject var favorites: Favorites
    @State private var imageData: Data?
    @State private var isFavorite = false
    @State private var isCarted = false

    var body: some View {
        VStack {
            if let imageData = imageData, let uiImage = UIImage(data: imageData) {
                Image(uiImage: uiImage)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            } else {
                Image(systemName: "photo")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 100, height: 100)
            }
            
            Text(item.name)
                .font(.caption)
                .multilineTextAlignment(.center)
            
            Text("$\(String(format: "%.2f", item.price))")
                .font(.caption2)
                .foregroundColor(.gray)
            
            HStack {
                Button(action: {
                    if isFavorite {
                        favorites.removeItem(item)
                    } else {
                        favorites.addItem(item)
                    }
                    isFavorite.toggle()
                }) {
                    Image(systemName: isFavorite ? "heart.fill" : "heart")
                        .foregroundColor(isFavorite ? .red : .black)
                }
                
                Spacer()
                
                Button(action: {
                    if isCarted {
                        cart.removeItem(item)
                    } else {
                        cart.addItem(item)
                    }
                    isCarted.toggle()
                }) {
                    Image(systemName: isCarted ? "cart.fill" : "cart")
                        .foregroundColor(isCarted ? .blue : .black)
                }
            }
        }
        .frame(width: 120)
        .padding()
        .background(Color.white)
        .cornerRadius(10)
        .shadow(radius: 5)
        .onAppear {
            // Fetch image data from URL
            guard let url = URL(string: item.icon) else { return }
            URLSession.shared.dataTask(with: url) { data, _, error in
                if let data = data {
                    DispatchQueue.main.async {
                        self.imageData = data
                    }
                } else {
                    print("Failed to fetch image: \(error?.localizedDescription ?? "Unknown error")")
                }
            }.resume()
        }
    }
}


struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleItem = Item(id: 1, name: "Sample Item", icon: "sample-icon", price: 9.99)
        
        let cart = Cart()
        let favorites = Favorites()
        
        return ItemView(item: sampleItem)
            .environmentObject(cart)
            .environmentObject(favorites)
    }
}
