

import SwiftUI

struct MainView: View {
    var body: some View {
        VStack{
            DashboardView()
                .frame(width: 400, height: 124)
            TabBarView()
  
        }
    }
}

#Preview {
    MainView()
}
