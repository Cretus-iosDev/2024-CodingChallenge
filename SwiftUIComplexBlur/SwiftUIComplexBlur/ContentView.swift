

import SwiftUI

struct ContentView: View {
    @State var isBlur: Bool = false
    var body: some View {
        VStack {
            Text("Rutik \nMaraskolhe")
                .font(.system(size: 70))
                .bold()
                .foregroundColor(.yellow)
                .onTapGesture {
                    self.isBlur.toggle()
                }
        }
        .modifier(BlurModifier(showBlur: $isBlur, content: {
            VStack(spacing: 10) {
                Color.black.opacity(0.1)
            }.ignoresSafeArea()
                .onTapGesture {
                    isBlur.toggle()
                }
        }))
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.black)
        
    }
}

#Preview {
    ContentView()
}
