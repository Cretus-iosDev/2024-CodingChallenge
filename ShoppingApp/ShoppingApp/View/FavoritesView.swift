import SwiftUI

struct FavoritesView: View {
    @EnvironmentObject var favorites: Favorites
    
    var body: some View {
        VStack {
            Text("Favorites")
                .font(.title)
                .padding()
            
            List {
                ForEach(favorites.items) { item in
                    Text(item.name)
                }
            }
            .id(UUID()) // Ensure that the list updates when favorites change
        }
    }
}

struct FavoritesView_Previews: PreviewProvider {
    static var previews: some View {
        let favorites = Favorites()
        favorites.addItem(Item(id: 1, name: "Sample Item 1", icon: "sample-icon-1", price: 9.99))
        favorites.addItem(Item(id: 2, name: "Sample Item 2", icon: "sample-icon-2", price: 14.99))
        
        return FavoritesView()
            .environmentObject(favorites)
    }
}


