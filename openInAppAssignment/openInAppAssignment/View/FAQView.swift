

import SwiftUI

struct FAQView: View {
    var body: some View {
        Button(action: {
        
        }) {
            VStack(alignment: .leading, spacing: 16) {
                HStack(spacing: 12){
                    Image("question-mark")
                    Text("Frequently Asked Questions")
                        .font(.custom(FontsManager.Figtree.SemiBold, size: 16))
                        .foregroundColor(.black)
                }
                .padding(.trailing, 52)
                .frame(width: 328, height: 64)
                .background(Color(red: 0.91, green: 0.94, blue: 1))
                .cornerRadius(8)
                .overlay(
                  RoundedRectangle(cornerRadius: 8)
                    .inset(by: 0.50)
                    .stroke(
                      Color(red: 0.05, green: 0.44, blue: 1).opacity(0.32), lineWidth: 2
                    )
                )
            }
        }
    }
}

#Preview {
    FAQView()
}
