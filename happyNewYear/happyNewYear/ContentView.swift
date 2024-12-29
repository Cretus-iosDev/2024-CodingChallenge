import SwiftUI
import SpriteKit
import Lottie

struct HappyNewYearView: View {
    @State private var showNewYear = false // Toggle state
    @State private var animateText = false // Animation state for text
    
    var body: some View {
        ZStack {
            // Background
            LinearGradient(
                colors: [.black, .blue, .purple],
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            // Fireworks: Only show when toggle is on
            if showNewYear {
                LottieView(animationName: "fireworks")
                    .ignoresSafeArea()
            }

            // Main Content
            VStack {
                // Toggle
                Toggle(isOn: $showNewYear.animation()) {
                    Text("Celebrate New Year")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                }
                .toggleStyle(SwitchToggleStyle(tint: .yellow))
                .padding()

                Spacer()

                // Year and Happy New Year Text
                VStack {
                    Text("Happy New Year")
                        .font(.largeTitle)
                        .foregroundColor(.white)
                        .shadow(color: .yellow, radius: 10, x: 0, y: 0)
                        .opacity(showNewYear ? 1 : 0) // Fade in/out based on toggle state
                        .scaleEffect(showNewYear ? 1 : 0.5) // Scale effect when visible
                        .animation(.easeInOut(duration: 1.5), value: showNewYear)

                    Text("2025")
                        .font(.system(size: 72, weight: .bold))
                        .foregroundColor(.yellow)
                        .shadow(color: .orange, radius: 10, x: 0, y: 0)
                        .opacity(showNewYear ? 1 : 0) // Fade in/out based on toggle state
                        .scaleEffect(showNewYear ? 1 : 0.5) // Scale effect when visible
                        .rotationEffect(.degrees(showNewYear ? 0 : -15)) // Slight rotation effect
                        .animation(.easeInOut(duration: 1.5).delay(0.5), value: showNewYear)
                }

                // "2024" Text
                Text("2024")
                    .font(.system(size: 72, weight: .bold))
                    .foregroundColor(.white)
                    .shadow(color: .gray, radius: 10, x: 0, y: 0)
                    .opacity(showNewYear ? 0 : 1) // Fade out when toggle is on
                    .scaleEffect(showNewYear ? 0.5 : 1) // Shrink when not visible
                    .animation(.easeInOut(duration: 1.5), value: showNewYear)

                Spacer()
            }
        }
        .onAppear {
            // Initially show 2024 with no fireworks or Happy New Year
            withAnimation {
                animateText = false
            }
        }
        .onChange(of: showNewYear) { newValue in
            if newValue {
                // Trigger text animation and fireworks when toggled on
                withAnimation {
                    animateText = true
                }
            } else {
                // Reset animation and text when toggled off
                withAnimation {
                    animateText = false
                }
            }
        }
    }
}

// FireworkParticleView and FireworksScene (same as before)

struct FireworkParticleView: UIViewRepresentable {
    func makeUIView(context: Context) -> SKView {
        let skView = SKView()
        skView.presentScene(FireworksScene(size: UIScreen.main.bounds.size))
        skView.ignoresSiblingOrder = true
        return skView
    }

    func updateUIView(_ uiView: SKView, context: Context) {}
}

class FireworksScene: SKScene {
    override func didMove(to view: SKView) {
        backgroundColor = .clear
        run(SKAction.repeatForever(SKAction.sequence([
            SKAction.run(createFirework),
            SKAction.wait(forDuration: 1.0)
        ])))
    }

    private func createFirework() {
        let firework = SKEmitterNode(fileNamed: "Firework.sks") ?? SKEmitterNode()
        firework.position = CGPoint(x: CGFloat.random(in: 100...size.width - 100), y: 0)
        addChild(firework)

        let moveUp = SKAction.moveBy(x: 0, y: size.height, duration: 2.0)
        let fadeOut = SKAction.fadeOut(withDuration: 1.0)
        let remove = SKAction.removeFromParent()
        firework.run(SKAction.sequence([moveUp, fadeOut, remove]))
    }
}

// LottieView (same as before)

struct LottieView: UIViewRepresentable {
    var animationName: String

    func makeUIView(context: Context) -> UIView {
        let view = UIView(frame: .zero)
        let animationView = LottieAnimationView(name: animationName)
        animationView.contentMode = .scaleAspectFill
        animationView.loopMode = .loop
        animationView.play()

        animationView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(animationView)

        NSLayoutConstraint.activate([
            animationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            animationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            animationView.topAnchor.constraint(equalTo: view.topAnchor),
            animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
        ])

        return view
    }

    func updateUIView(_ uiView: UIView, context: Context) {}
}

// Preview
struct HappyNewYearView_Previews: PreviewProvider {
    static var previews: some View {
        HappyNewYearView()
    }
}
