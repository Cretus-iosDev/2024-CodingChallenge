import SwiftUI

struct ViewAnalyticsButton: View {
    var body: some View {
        Button(action: {
        
        }) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12){
                    Image("Arrows")
                        .foregroundColor(.black)
                    Text("View Analytics")
                        .font(.custom(FontsManager.Figtree.SemiBold, size: 18))
                        .foregroundColor(.black)
                }
                .frame(width: 328, height: 64)
               
                .cornerRadius(8)
                .overlay(
                  RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.50)
                    .stroke(Color(red: 0.85, green: 0.85, blue: 0.85), lineWidth: 2)
                )
               
            }
        }
    }
}

#Preview {
    ViewAnalyticsButton()
}
