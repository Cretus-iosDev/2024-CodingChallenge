import Foundation


struct TMDBResponse: Decodable {
    let results: [Movie]
}

class MovieFetcher {
    private let apiKey = "38a73d59546aa378980a88b645f487fc"
    private let baseUrl = "https://api.themoviedb.org/3"
    
    func fetchMovies(completion: @escaping ([Movie]) -> Void) {
        let url = URL(string: "\(baseUrl)/movie/popular?api_key=\(apiKey)")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let response = try JSONDecoder().decode(TMDBResponse.self, from: data)
                    completion(response.results)
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}


