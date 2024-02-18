import Foundation

struct Item: Identifiable, Decodable {
    var id: Int
    var name: String
    var icon: String // URL for the image
    var price: Double
}

struct Category: Identifiable, Decodable {
    var id: Int
    var name: String
    var items: [Item]
}

struct ResponseData: Decodable {
    var status: Bool
    var message: String
    var error: String?
    var categories: [Category]
}

enum DataManagerError: Error {
    case fileNotFound
    case invalidData
}
