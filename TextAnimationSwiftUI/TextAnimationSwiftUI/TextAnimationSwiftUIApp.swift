
import SwiftUI

@main
struct TextAnimationSwiftUIApp: App {
    @State var show = false
    var body: some Scene {
        WindowGroup {
            ZStack {
                if show {
                    HomeView()
                } else {
                    ContentView()
                }
            }
            .onAppear() {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                    withAnimation{
                        show = true
                    }
                }
            }
        }
    }
}
