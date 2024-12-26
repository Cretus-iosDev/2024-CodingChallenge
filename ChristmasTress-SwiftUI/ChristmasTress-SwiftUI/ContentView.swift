import SwiftUI

struct ChristmasTreeView: View {
    @StateObject private var viewModel = ChristmasTreeViewModel()
    @State private var animateText = false // State for text animation
    @State private var starGlow = false   // State for star glow animation
    @State private var glowRotation = 0.0 // Rotation state for glowing effect
    @State private var radius: CGFloat = 100 // Initial radius of the spiral path
    @State private var spiralEffect = false  // State for spiral effect animation

    var body: some View {
        ZStack {
            // Gradient Night Sky
            LinearGradient(colors: [Color.blue, Color.black],
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            // Snowflakes
            ForEach(viewModel.snowflakes) { snowflake in
                Circle()
                    .fill(Color.white)
                    .frame(width: snowflake.size, height: snowflake.size)
                    .position(snowflake.position)
                    .opacity(snowflake.opacity)
                    .animation(Animation.linear(duration: 3).repeatForever(), value: snowflake.position)
            }

            // Tree Layers
            VStack(spacing: -35) {
                ForEach(0..<5) { i in
                    Triangle()
                        .fill(
                            LinearGradient(colors: [.green.opacity(0.9), .green.opacity(0.7)],
                                           startPoint: .top,
                                           endPoint: .bottom)
                        )
                        .frame(width: 220 - CGFloat(i * 40), height: 160)
                        .shadow(color: .black.opacity(0.2), radius: 5, x: 0, y: 5)
                }
            }

            // Star
            StarShape()
                .fill(
                    LinearGradient(colors: [.yellow, .orange], startPoint: .top, endPoint: .bottom)
                )
                .frame(width: 80, height: 80)
                .glow(starGlow ? 50 : 20, color: .yellow)
                .offset(y: -300)
                .onAppear {
                    withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                        starGlow.toggle()
                    }
                }

            // Glowing Lights with Spiral Effect
            ZStack {
                ForEach(0..<12) { index in
                    let angle = CGFloat(index) * CGFloat.pi / 6 + CGFloat(glowRotation)
                    let xOffset = radius * cos(angle)
                    let yOffset = radius * sin(angle)

                    Circle()
                        .fill(Color.yellow)
                        .frame(width: 15, height: 15)
                        .glow(20, color: .yellow)
                        .offset(x: xOffset, y: yOffset)
                        .onAppear {
                            withAnimation(Animation.linear(duration: 8).repeatForever(autoreverses: false)) {
                                glowRotation += 2 * CGFloat.pi
                            }
                        }
                        .onChange(of: glowRotation) { _ in
                            withAnimation(Animation.linear(duration: 1).repeatForever(autoreverses: false)) {
                                radius += 10 // Increase the radius to create the spiral effect
                            }
                        }
                }
            }

            // Lights
            ForEach(viewModel.lights) { light in
                Circle()
                    .fill(light.color)
                    .frame(width: 12, height: 12)
                    .opacity(light.opacity)
                    .animation(Animation.easeInOut(duration: 1).repeatForever(), value: light.opacity)
                    .position(light.position)
            }

            // Merry Christmas Text
            VStack {
                Spacer().frame(height: 40) // Adjust this based on spacing needed below the notch
                Text("Merry Christmas")
                    .font(.custom("Snell Roundhand", size: 36).weight(.bold))
                    .foregroundColor(.white)
                    .scaleEffect(animateText ? 1.1 : 1.0)
                    .opacity(animateText ? 1.0 : 0.8)
                    .shadow(color: .white.opacity(0.8), radius: 10, x: 0, y: 5)
                    .padding(.top, 20) // Add space below the notch
                    .onAppear {
                        withAnimation(Animation.easeInOut(duration: 2).repeatForever(autoreverses: true)) {
                            animateText.toggle()
                        }
                    }
                    .padding(.bottom, 780) // Keeps the rest of the content centered
            }
        }
        .onAppear {
            viewModel.startSnowfall()
        }
    }
}




// Triangle Shape
struct Triangle: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()
        path.move(to: CGPoint(x: rect.midX, y: rect.minY)) // Top center
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY)) // Bottom left
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.maxY)) // Bottom right
        path.closeSubpath()
        return path
    }
}

// Updated StarShape for a Perfect Star
struct StarShape: Shape {
    func path(in rect: CGRect) -> Path {
        let center = CGPoint(x: rect.midX, y: rect.midY)
        let radius = rect.width / 2
        let innerRadius = radius * 0.5
        let points = 10
        let angle = .pi * 2 / CGFloat(points)
        
        var path = Path()
        for i in 0..<points {
            let radius = i.isMultiple(of: 2) ? radius : innerRadius
            let x = center.x + radius * cos(CGFloat(i) * angle - .pi / 2)
            let y = center.y + radius * sin(CGFloat(i) * angle - .pi / 2)
            if i == 0 {
                path.move(to: CGPoint(x: x, y: y))
            } else {
                path.addLine(to: CGPoint(x: x, y: y))
            }
        }
        path.closeSubpath()
        return path
    }
}


// Glow Effect Modifier
extension View {
    func glow(_ radius: CGFloat, color: Color) -> some View {
        self.overlay(
            self.shadow(color: color.opacity(0.6), radius: radius, x: 0, y: 0)
                .blur(radius: radius / 2)
        )
        .shadow(color: color.opacity(0.4), radius: radius / 1.5, x: 0, y: 0)
    }
}


// View Model
class ChristmasTreeViewModel: ObservableObject {
    @Published var snowflakes: [Snowflake] = []
    @Published var lights: [Light] = []

    init() {
        startSnowfall()
        generateLights()
    }

    func startSnowfall() {
        let snowflakeCount = 100
        snowflakes = (0..<snowflakeCount).map { _ in
            Snowflake(
                position: CGPoint(x: CGFloat.random(in: 0...UIScreen.main.bounds.width),
                                  y: CGFloat.random(in: 0...UIScreen.main.bounds.height)),
                size: CGFloat.random(in: 2...6),
                opacity: Double.random(in: 0.5...1.0)
            )
        }
    }

    func generateLights() {
        let lightCount = 30
        lights = (0..<lightCount).map { _ in
            Light(
                position: CGPoint(x: CGFloat.random(in: 50...UIScreen.main.bounds.width - 50),
                                  y: CGFloat.random(in: 200...UIScreen.main.bounds.height - 300)),
                color: [.red, .green, .yellow, .blue, .purple].randomElement()!,
                opacity: Double.random(in: 0.5...1.0)
            )
        }
    }
}

// Snowflake Model
struct Snowflake: Identifiable {
    let id = UUID()
    var position: CGPoint
    var size: CGFloat
    var opacity: Double
}

// Light Model
struct Light: Identifiable {
    let id = UUID()
    var position: CGPoint
    var color: Color
    var opacity: Double
}

// Preview
struct ChristmasTreeView_Previews: PreviewProvider {
    static var previews: some View {
        ChristmasTreeView()
    }
}
