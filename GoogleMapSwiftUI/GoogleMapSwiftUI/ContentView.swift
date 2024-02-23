import SwiftUI
import GoogleMaps


struct ContentView: View {
    @State private var totalDistance: CLLocationDistance = 0.0
    var body: some View {
        VStack {
            MapView(totalDistance: $totalDistance)
                .edgesIgnoringSafeArea(.all)
            Text("Total Distance: \(String(format: "%.2f", totalDistance)) meters")
                           .padding()
        }
    }
}

#Preview {
    ContentView()
}
