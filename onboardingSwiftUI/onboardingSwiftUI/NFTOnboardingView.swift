//MARK: PART-2
import SwiftUI

struct NFTOnboardingView: View {
    @State private var currentIndex = 0
    @State private var rotationAngle: Double = 0.0

    var body: some View {
        VStack {
            Spacer()

            Image(onboardingScreens[currentIndex].image)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)
                .rotationEffect(.degrees(rotationAngle))
                .onAppear {
                    withAnimation(.linear(duration: 5).repeatForever(autoreverses: false)) {
                        rotationAngle = 360
                    }
                }

            Text(onboardingScreens[currentIndex].title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)
                .foregroundColor(.white)

            Text(onboardingScreens[currentIndex].subtitle)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 20)
                .padding(.top, 10)
                .foregroundColor(.white)

            HStack(spacing: 10) {
                ForEach(0..<onboardingScreens.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.green : Color.gray)
                        .frame(width: 8, height: 8)
                }
            }
            .padding(.top, 20)

            Spacer()

            Button(action: {
                if currentIndex < onboardingScreens.count - 1 {
                    currentIndex += 1
                } else {
                    // Handle "Get Started" action
                }
            }) {
                Text("Get Started")
                    .font(.headline)
                    .foregroundColor(.black)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.green)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
            }
            .padding(.bottom, 20)
        }
        .background(Color.black.edgesIgnoringSafeArea(.all))
    }
}

#Preview {
    NFTOnboardingView()
}

let onboardingScreens = [
    OnboardingData(image: "nft1", title: "Create your own collection", subtitle: "We enable everyone and anyone to create and start collecting NFTs."),
    OnboardingData(image: "nft2", title: "A new NFT experience", subtitle: "Discover, collect and sell extraordinary NFTs on the best marketplace."),
    OnboardingData(image: "nft3", title: "Join in building the future", subtitle: "With over 800 rare collectables, you have a shot at building the future.")
]
