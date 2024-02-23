import GoogleMaps
import GooglePlaces
import SwiftUI


let APIKey = "YOUR____API___KEY"


@main
struct GoogleMapSwiftUIApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}

class AppDelegate: NSObject,UIApplicationDelegate {
    func application(_ application:UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey :
                                                                    Any]? = nil) -> Bool {
        
        GMSServices.provideAPIKey(APIKey)
        GMSPlacesClient.provideAPIKey(APIKey)
        return true
    }
    
  
}
