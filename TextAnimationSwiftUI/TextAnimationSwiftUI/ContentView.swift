

import SwiftUI

struct ContentView: View {
    @State var show  = false
    let title = "RUTIK"
    private var initialDelays = [0.0, 0.04, 0.012, 0.018,0.28,0.35]
    var body: some View {
        ZStack {
            ZStack {
                AnimatedTitleView(title: title, color: .C_5, initialDelay: initialDelays[5], animationType: .spring(duration: 1))
                AnimatedTitleView(title: title, color: .C_4, initialDelay: initialDelays[4], animationType: .spring(duration: 1))
                AnimatedTitleView(title: title, color: .C_3, initialDelay: initialDelays[3], animationType: .spring(duration: 1))
                AnimatedTitleView(title: title, color: .C_2, initialDelay: initialDelays[2], animationType: .spring(duration: 1))
                AnimatedTitleView(title: title, color: .C_1, initialDelay: initialDelays[1], animationType: .spring(duration: 1))
                
                
            }
            AnimatedTitleView(title: title, color: .C_0, initialDelay: initialDelays[0], animationType: .spring)
        }
       
       
        
    }
}

#Preview {
    ContentView()
}


struct AnimatedTitleView: View {
    
    
    let title: String
    let color: Color
    let initialDealy: Double
    let animationType: Animation
    @State var scall = false
    @State private var show = false
    private var delayStep = 0.1
    
    init(title: String, color: Color, initialDelay: Double, animationType: Animation) {
        self.title = title
        self.color = color
        self.initialDealy = initialDelay
        self.animationType = animationType

    }
    
    var body: some View {
        HStack(spacing: 0) {
            ForEach(0..<title.count, id: \.self) {
                index in
                Text(String(title[title.index(title.startIndex,offsetBy: index)]))
                    .font(.system(size: 80)).bold()
                    .opacity(show ? 1 : 0)
                    .offset(y: show ? -30 : 30)
                    .animation(animationType.delay(Double(index) * delayStep + initialDealy), value: show)
                    .foregroundStyle(color)
            }
        }
        .scaleEffect(scall ? 1: 1.2)
        .onAppear() {
            show.toggle()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.6) {
                withAnimation{
                    scall.toggle()
                }
            }
        }
    }
    
}
