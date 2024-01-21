import SwiftUI

struct Home: View {
    @EnvironmentObject private var appData: AppData
    var body: some View {
        TabView(selection: $appData.activeTab) {
            HomeView()
                .tag(Tab.home)
                .tabItem {
                    Image(systemName: Tab.home.symbolImage)
                }
            
            FavouriteView()
                .tag(Tab.favourite)
                .tabItem {
                    Image(systemName: Tab.favourite.symbolImage)
                }
            
            SettingView()
                .tag(Tab.settings)
                .tabItem {
                    Image(systemName: Tab.settings.symbolImage)
                }
        }
        .tint(.red)
    }
    
    /// Home View With Nav View's
    @ViewBuilder
    func HomeView() -> some View {
        NavigationStack(path: $appData.homeNavStack) {
            List {
                ForEach(HomeStack.allCases, id: \.rawValue) { link in
                    NavigationLink(value: link) {
                        Text(link.rawValue)
                    }
                }
            }
            .navigationTitle("Home")
            .navigationDestination(for: HomeStack.self) { link in
                /// USE SWITCH CASE TO SWITCH VIEW FOR EACH ENUM CASE
                /// FOR VIDEO PURPOSE IN SIMPLY USING TEXT
                Text(link.rawValue + "View")
                
            }
            
        }
    }
    
    /// Favourite View With Nav View's
    @ViewBuilder
    func FavouriteView() -> some View {
        NavigationStack(path: $appData.favouriteNavStack) {
            List {
                ForEach(FavouriteStack.allCases, id: \.rawValue) { link in
                    NavigationLink(value: link) {
                        Text(link.rawValue)
                    }
                }
            }
            .navigationTitle("Favourite")
            .navigationDestination(for: FavouriteStack.self) { link in
                /// USE SWITCH CASE TO SWITCH VIEW FOR EACH ENUM CASE
                /// FOR VIDEO PURPOSE IN SIMPLY USING TEXT
                Text(link.rawValue + "View")
                
            }
            
        }
    }
    
    /// Setting ViewWith Nav View's
    @ViewBuilder
    func SettingView() -> some View {
        NavigationStack(path: $appData.settingNavStack) {
            List {
                ForEach(SettingStack.allCases, id: \.rawValue) { link in
                    NavigationLink(value: link) {
                        Text(link.rawValue)
                    }
                }
            }
            .navigationTitle("Setting")
            .navigationDestination(for: SettingStack.self) { link in
                /// USE SWITCH CASE TO SWITCH VIEW FOR EACH ENUM CASE
                /// FOR VIDEO PURPOSE IN SIMPLY USING TEXT
                Text(link.rawValue + "View")
                
            }
            
        }
    }
}

#Preview {
    ContentView()
        .environmentObject(AppData())
}
