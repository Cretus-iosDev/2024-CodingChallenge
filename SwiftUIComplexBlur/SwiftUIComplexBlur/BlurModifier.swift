
import SwiftUI

struct BlurModifier<BlurContent: View>:  ViewModifier {
    @Binding var showBlur: Bool
    @State var blurRadius: CGFloat = 10
    
    let content: () -> BlurContent
    
    func body(content: Content) -> some View {
        Group {
            content
                .blur(radius: showBlur ? blurRadius : 0)
                .animation(.easeInOut, value: showBlur)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay {
            self.content()
                .opacity(showBlur ? 1 : 0)
                .animation(.easeInOut(duration: 0.4), value:  showBlur)
        }
    }
    
    
    
}

