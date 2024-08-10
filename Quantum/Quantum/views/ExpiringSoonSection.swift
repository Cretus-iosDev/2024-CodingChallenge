import SwiftUI

struct ExpiringSoonSection: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text("Expiring Soon")
                .font(.headline)

            VStack(alignment: .leading, spacing: 15) {
                HStack {
                    Text("Total Products")
                        .foregroundColor(.white)
                    Text("12")
                        .padding(5)
                        .background(Color.white)
                        .cornerRadius(20)
                    Spacer()
                    NavigationLink(destination: AllExpiringProductsView()) {
                        Text("View all")
                            .foregroundColor(.white)
                    }
                }

                ForEach(0..<3) { _ in
                    ExpiringSoonItem()
                }
            }
            .padding()
            .background(Color.green)
            .cornerRadius(15)
        }
        //.padding()
    }
}

#Preview {
    ExpiringSoonSection()
}









