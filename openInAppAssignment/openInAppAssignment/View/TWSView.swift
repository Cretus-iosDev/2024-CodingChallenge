import SwiftUI

struct TWSView: View {
    var body: some View {
        Button(action: {
        
        }) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12){
                    Image("What'sApp")
                    Text("Talk with us")
                        .font(.custom(FontsManager.Figtree.SemiBold, size: 16))
                        .foregroundColor(.black)
                }
                .padding(.trailing, 172)
                .frame(width: 328, height: 64)
                .background(Color(red: 0.29, green: 0.82, blue: 0.37).opacity(0.12))
                .cornerRadius(8)
                .overlay(
                  RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.50)
                    .stroke(
                      Color(red: 0.29, green: 0.82, blue: 0.37).opacity(0.32), lineWidth: 2
                    )
                )
            }
        }
    }
}


#Preview {
    TWSView()
}
