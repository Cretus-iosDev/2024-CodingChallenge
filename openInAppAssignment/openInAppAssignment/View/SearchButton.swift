import SwiftUI

struct SearchButton: View {
    var body: some View {
        Button(action: {
            print("Search button tapped")
        }) {
            Image("search")
        }
        .frame(width: 36, height: 36)
        .background(Color(red: 0.95, green: 0.95, blue: 0.95))
        .cornerRadius(8)
    }
}


#Preview {
    SearchButton()
}
