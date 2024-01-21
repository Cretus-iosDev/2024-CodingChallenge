

import SwiftUI

/// Settings View Nav Stack
enum SettingStack: String, CaseIterable {
    case myProfile = "My Profile"
    case dataUsage = "Data Usage"
    case privacyPolicy = "Privacy Policy"
    case termsOfService = "Terms of Service"
    
    static func convert(from: String) -> Self? {
        return self.allCases.first { tab in
            tab.rawValue.lowercased() == from.lowercased()
        }
    }
}
