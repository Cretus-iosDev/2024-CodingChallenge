import SwiftUI

struct ExpiringSoonItem: View {
    var body: some View {
        HStack {
            Image("img1")
                .resizable()
                .scaledToFill()
                .frame(width: 160, height: 160)
                .clipShape(RoundedRectangle(cornerRadius: 10))
            
            VStack(alignment: .leading,spacing: 12) {
                Text("Onion bag")
                    .foregroundColor(.white)
                    .fontWeight(.semibold)
                Text("Expiry date : 02/05/2024")
                    .font(.caption)
                    .foregroundColor(.white.opacity(0.8))
                Button(action: {}) {
                    Text("View details")
                        .font(.caption)
                        .padding(5)
                        .background(Color.white)
                        .foregroundColor(.green)
                        .cornerRadius(10)
                }
            }
            .padding(.trailing,20)
            
           
            
           
        }
    }
}
#Preview {
    ExpiringSoonItem()
}
