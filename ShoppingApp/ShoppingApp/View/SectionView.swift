import SwiftUI

struct SectionView: View {
    let category: Category
    @State private var isExpanded: Bool = false
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(category.name)
                    .font(.title)
                Spacer()
                Button(action: {
                    isExpanded.toggle()
                }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                }
               
            }
            .padding(.vertical)
            
            if isExpanded {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 20) {
                        ForEach(category.items) { item in
                            ItemView(item: item)
                        }
                    }
                    .padding(.horizontal)
                }
            }
        }
        .background(Color.gray.opacity(0.1))
        .cornerRadius(10)
        .padding(.bottom, 10)
    }
}


struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleCategory = Category(id: 1, name: "Sample Category", items: [
            Item(id: 1, name: "Item 1", icon: "icon1", price: 10.0),
            Item(id: 2, name: "Item 2", icon: "icon2", price: 20.0),
            Item(id: 3, name: "Item 3", icon: "icon3", price: 30.0)
        ])
        
        return SectionView(category: sampleCategory)
    }
}
