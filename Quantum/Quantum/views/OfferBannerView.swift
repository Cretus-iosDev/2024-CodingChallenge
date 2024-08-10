import SwiftUI

struct OfferBannerView: View {
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 16) {
                        ForEach(0..<5) { _ in
                            PromoBannerView()
                        }
                    }
                    .padding()
                }
    }
}

#Preview {
    OfferBannerView()
}


struct PromoBannerView: View {
    var body: some View {
        HStack(spacing: 0) {
            ZStack {
                StarCutoutShape()
                    .foregroundColor(Color.yellow)
                    .frame(width: 100, height: 100)
                
                Image(systemName: "flame.fill")
                    .foregroundColor(.orange)
                    .font(.system(size: 40))
                    .padding(.trailing,25)
            }
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Just for you !")
                    .font(.headline)
                    .foregroundColor(.white)
                Text("Claim your exclusive offer today")
                    .font(.subheadline)
                    .foregroundColor(.white)
            }
            .padding(.leading, 8)
            .frame(height: 100)
            
            Spacer()
        }
        .padding()
        .background(Color.green)
        .cornerRadius(16)
        .shadow(radius: 5)
    }
}


struct StarCutoutShape: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        let cutoutWidth: CGFloat = 30
        let cutoutHeight: CGFloat = rect.height
        
        path.move(to: CGPoint(x: rect.minX, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - cutoutWidth, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX - cutoutWidth, y: rect.minY + cutoutHeight / 2 - cutoutWidth / 2))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.minY + cutoutHeight / 2))
        path.addLine(to: CGPoint(x: rect.maxX - cutoutWidth, y: rect.minY + cutoutHeight / 2 + cutoutWidth / 2))
        path.addLine(to: CGPoint(x: rect.maxX - cutoutWidth, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.minX, y: rect.maxY))
        path.closeSubpath()

        return path
    }
}


