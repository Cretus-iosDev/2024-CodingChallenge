import SwiftUI
import GoogleMaps
import GooglePlaces

let APIKey = "AIzaSyCE6d2-Dvki9iPBtaP6NRO9WQFnSR4M7XI"


@main
struct MyApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    @State var selection:Int = 0
    
    @StateObject var stateHandler:StateHandler = StateHandler() //Saves Map's config, used when map is re-renderd every time location(current) is changed
    
    var body: some Scene {
        WindowGroup {
            TabView(selection: $selection) {
               
                NavigationView{
                    DirectionsView()
                        .environmentObject(stateHandler)
                        .navigationTitle("Directions")
//                        .navigationBarTitleDisplayMode(.inline)
                }
                
                .tag(0)
                .tabItem {
                    VStack{
                        Image(systemName: selection == 1 ? "location.fill" : "location")
                        Text("Directions")
                    }.tint(.orange)
                }
                
                
            }
        }
    }
}


class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        GMSServices.provideAPIKey(APIKey)
        GMSPlacesClient.provideAPIKey(APIKey)
        
        return true
    }
}
