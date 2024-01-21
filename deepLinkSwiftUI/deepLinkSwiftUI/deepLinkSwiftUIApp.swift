
import SwiftUI

@main
struct deepLinkSwiftUIApp: App {
    /// State Object, Contains Whole App Data and Passes it VIA Environment Object
    @StateObject private var appData: AppData = .init()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(appData)
            /// Called when Deep Link was Triggered
                .onOpenURL { url in
                    let string = url.absoluteString.replacingOccurrences(of: "deeplink://", with: "")
                    /// Spliting URL Component's
                    let components = string.components(separatedBy: "?")
                    
                    for component in components {
                        if component.contains("tab=") {
                            /// Tab Change Request
                            let tabRawValue = component.replacingOccurrences(of: "tab=", with: "")
                            if let requestTab = Tab.convert(from: tabRawValue) {
                                appData.activeTab = requestTab
                            }
                        }
                        
                        /// Navigation will only be updated if the link contains or specifies which tab navigation needs to be chnaged
                        if component.contains("nav=") && string.contains("tab") {
                            // Nav Change Request
                            let requestedNavPath = component
                                .replacingOccurrences(of: "nav=", with: "")
                                .replacingOccurrences(of: "_", with: " ")
                            
                            switch appData.activeTab {
                            case .home:
                                if let navpath = HomeStack.convert(from: requestedNavPath) {
                                    appData.homeNavStack.append(navpath)
                                }
                            case .favourite:
                                if let navpath = FavouriteStack.convert(from: requestedNavPath) {
                                    appData.favouriteNavStack.append(navpath)
                                }
                            case .settings:
                                if let navpath = SettingStack.convert(from: requestedNavPath) {
                                    appData.settingNavStack.append(navpath)
                                }
                            }
                        }
                    }
                }
        }
    }
}
