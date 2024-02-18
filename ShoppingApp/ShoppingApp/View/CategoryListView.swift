import SwiftUI

struct CategoryListView: View {

    @State private var categories = [Category]()

    var body: some View {
        NavigationView {
            List(categories) { category in
                NavigationLink(destination: CategoryDetailView(category: category)) {
                    Text(category.name)
                }
            }
            .navigationTitle("Categories")
        }
        .onAppear(perform: fetchCategories)
    }

    private func fetchCategories() {
        // Call API service
        // Decode response
        // Update categories
    }
}

#Preview {
    CategoryListView()
}
