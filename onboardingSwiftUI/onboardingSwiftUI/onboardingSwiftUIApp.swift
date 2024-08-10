

import SwiftUI

@main
struct onboardingSwiftUIApp: App {
    var body: some Scene {
        WindowGroup {
            NFTOnboardingView()
        }
    }
}


struct OnboardingData {
    let image: String
    let title: String
    let subtitle: String
}
