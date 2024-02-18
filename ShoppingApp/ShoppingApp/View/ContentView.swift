import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ContentViewModel()
    @State private var showingFavorites = false
    @State private var showingCart = false

    var body: some View {
        NavigationView {
            Group {
                if let responseData = viewModel.responseData {
                    ScrollView {
                        ForEach(responseData.categories) { category in
                            SectionView(category: category)
                        }
                    }
                    .padding()
                } else {
                    ProgressView("Fetching Data...")
                }
            }
            .navigationBarItems(leading:
                Button(action: {
                    showingCart = true
                }) {
                    Image(systemName: "cart.fill")
                }, trailing:
                Button(action: {
                    showingFavorites = true
                }) {
                    Image(systemName: "heart.fill")
                }
            )
            .navigationBarTitle("Shop")
            .sheet(isPresented: $showingFavorites) {
                FavoritesView()
            }
            .sheet(isPresented: $showingCart) {
                CartView()
            }
        }
        .onAppear {
            viewModel.fetchData()
        }
        .environmentObject(Cart())
        .environmentObject(Favorites())
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
























