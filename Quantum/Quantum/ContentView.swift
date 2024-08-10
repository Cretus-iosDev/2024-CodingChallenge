import SwiftUI

struct ContentView: View {
    @State private var selectedIndex: Int = 0

    var body: some View {
        VStack {
            // Content based on selected index
            ZStack {
                if selectedIndex == 0 {
                    HouseTabView()
                }
                // Add other views for different indexes Example:
                 if selectedIndex == 1 {
                     //ListTabView()
                 }
                 if selectedIndex == 2 {
                     //CameraView()
                 }
                 if selectedIndex == 3 {
                     //NotificationView()
                 }
                 if selectedIndex == 4 {
                     //ProfileView()
                 }
            }
            CustomTabBar(selectedIndex: $selectedIndex)
        }
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}





