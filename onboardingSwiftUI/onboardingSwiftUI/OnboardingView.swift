import SwiftUI

struct OnboardingView: View {
    @State private var currentIndex = 0

    var body: some View {
        VStack {
            Spacer()

            Image(onboardingScreens[currentIndex].image)
                .resizable()
                .scaledToFit()
                .frame(maxHeight: 300)

            Text(onboardingScreens[currentIndex].title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.top, 20)

            Text(onboardingScreens[currentIndex].subtitle)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding([.leading, .trailing], 20)
                .padding(.top, 10)

            HStack(spacing: 10) {
                ForEach(0..<onboardingScreens.count, id: \.self) { index in
                    Circle()
                        .fill(index == currentIndex ? Color.pink : Color.gray)
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
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.pink)
                    .cornerRadius(10)
                    .padding([.leading, .trailing], 20)
            }
            .padding(.bottom, 20)
        }
    }
}

#Preview {
    OnboardingView()
}

let OnboardingScreens = [
    OnboardingData(image: "onboarding1", title: "Access Anywhere", subtitle: "The video call feature can be accessed from anywhere in your house to help you."),
    OnboardingData(image: "onboarding2", title: "Don’t Feel Alone", subtitle: "Nobody likes to be alone and the built-in group video call feature helps you connect."),
    OnboardingData(image: "onboarding3", title: "Happiness", subtitle: "While working the app reminds you to smile, laugh, walk and talk with those who matter.")
]




