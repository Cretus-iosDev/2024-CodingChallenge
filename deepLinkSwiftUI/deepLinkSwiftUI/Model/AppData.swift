
import SwiftUI

/// App Data  Observable Object
class AppData: ObservableObject {
    @Published var activeTab: Tab = .home
    @Published var homeNavStack: [HomeStack] = []
    @Published var favouriteNavStack: [FavouriteStack] = []
    @Published var settingNavStack: [SettingStack] = []
}
