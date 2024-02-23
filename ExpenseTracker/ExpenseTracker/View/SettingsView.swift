import SwiftUI

struct SettingsView: View {
    @AppStorage("isDarkMode") private var isDarkMode = false
    
    var body: some View {
        VStack {
            Toggle("Dark Mode", isOn: $isDarkMode)
                .foregroundColor(.primary)
                .padding()
                .onChange(of: isDarkMode) { _ in
                    // Update app's appearance based on dark mode preference
                    if isDarkMode {
                        UIApplication.shared.windows.first?.rootViewController?.view.backgroundColor = .black
                    } else {
                        UIApplication.shared.windows.first?.rootViewController?.view.backgroundColor = .white
                    }
                }
            
            Button("Share App") {
                // Share app functionality
            }
            .padding()
            
            Button("Rate App") {
                // Rate app functionality
            }
            .padding()
        }
    }
}

#Preview {
    SettingsView()
}
