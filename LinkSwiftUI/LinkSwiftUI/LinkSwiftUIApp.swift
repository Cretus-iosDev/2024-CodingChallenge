
import SwiftUI

@main
struct LinkSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var urlHandler = URLHandler()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(urlHandler)
        }
    }
}

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication,
                     open url: URL,
                     options: [UIApplication.OpenURLOptionsKey : Any] = [:]) -> Bool {
        // Handle the URL by calling the handleIncomingURL method on the URLHandler
        let contentView = UIApplication.shared.windows.first?.rootViewController?.view as? ContentView
        contentView?.urlHandler.handleIncomingURL(url)

        return true
    }
}



class URLHandler: ObservableObject {
    @Published var userId = ""
    @Published var verificationToken: String?
    @Published var email: String?
    @Published var organization: String?
    @Published var isVerified: Bool?

    func handleIncomingURL(_ url: URL) {
        guard let components = URLComponents(url: url, resolvingAgainstBaseURL: true) else {
            print("Invalid URL components")
            return
        }

        guard let queryItems = components.queryItems else {
            print("No query items found")
            return
        }

        for item in queryItems {
            switch item.name {
            case "userId":
                userId = item.value ?? ""
            case "verificationToken":
                verificationToken = item.value
            case "email":
                email = item.value
            case "organization":
                organization = item.value
            case "isVerified":
                isVerified = (item.value == "true")
            default:
                break
            }
        }
    }
}



