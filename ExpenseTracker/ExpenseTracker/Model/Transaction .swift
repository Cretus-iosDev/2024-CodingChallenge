import Foundation

struct Transaction: Hashable {
    var id = UUID()
    var amount: Double
    var date: Date
    var category: String
   
}
