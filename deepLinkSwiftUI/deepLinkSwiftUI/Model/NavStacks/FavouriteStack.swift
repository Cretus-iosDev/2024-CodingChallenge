

import SwiftUI

/// Favourite View Nav Stack
enum FavouriteStack: String, CaseIterable {
    case iJustine = "iJustine"
    case kaviya = "Kaviya"
    case jenna = "Jenna"
    
    static func convert(from: String) -> Self? {
        return self.allCases.first { tab in
            tab.rawValue.lowercased() == from.lowercased()
        }
    }
}
