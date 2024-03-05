import SwiftUI

struct ContentView: View {
    @EnvironmentObject var urlHandler: URLHandler

    var body: some View {
        VStack {
            Text("Hello, world!")
            if !urlHandler.userId.isEmpty {
                Text("User ID: \(urlHandler.userId)")
            }
            if let verificationToken = urlHandler.verificationToken {
                Text("Verification Token: \(verificationToken)")
            }
            if let email = urlHandler.email {
                Text("Email: \(email)")
            }
            if let organization = urlHandler.organization {
                Text("Organization: \(organization)")
            }
            if let isVerified = urlHandler.isVerified {
                Text("Is Verified: \(isVerified ? "Yes" : "No")")
            }
        }
        .padding()
    }
}
#if DEBUG
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
#endif
