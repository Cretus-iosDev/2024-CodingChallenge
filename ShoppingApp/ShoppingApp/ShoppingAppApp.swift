
import SwiftUI

@main
struct ShoppingAppApp: App {
    let cart = Cart() // Create a Cart object
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(cart)
        }
    }
}
