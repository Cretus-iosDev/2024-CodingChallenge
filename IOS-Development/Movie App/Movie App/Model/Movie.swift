
import Foundation


struct Movie: Codable, Identifiable {
    let id: Int
    let title: String
    let posterPath: String
    
    
    enum CodingKeys: String, CodingKey {
        case id, title
        case posterPath = "poster_path"
    }
}


struct MovieDetails: Decodable {
    let overview: String
    let vote_average: Double
    let release_date: String
    let popularity: Double
    
    enum CodingKeys: String, CodingKey {
        case overview
        case vote_average
        case release_date
        case popularity
    }
}
