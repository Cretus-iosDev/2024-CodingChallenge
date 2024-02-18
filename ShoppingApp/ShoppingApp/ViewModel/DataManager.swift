import Foundation

class ContentViewModel: ObservableObject {
    @Published var responseData: ResponseData?
    let dataManager = DataManager()
    
    func fetchData() {
        dataManager.fetchData { result in
            switch result {
            case .success(let data):
                DispatchQueue.main.async {
                    self.responseData = data
                }
            case .failure(let error):
                print("Error fetching data: \(error)")
            }
        }
    }
}

class DataManager {
    func fetchData(completion: @escaping (Result<ResponseData, Error>) -> Void) {
        guard let url = Bundle.main.url(forResource: "shopping", withExtension: "json") else {
            completion(.failure(DataManagerError.fileNotFound))
            return
        }
        
        do {
            let jsonData = try Data(contentsOf: url)
            let responseData = try JSONDecoder().decode(ResponseData.self, from: jsonData)
            completion(.success(responseData))
        } catch {
            completion(.failure(error))
        }
    }
}


class Cart: ObservableObject {
    @Published var items: [Item] = []
    
    var totalPrice: Double {
        items.reduce(0) { $0 + $1.price }
    }
    
    func addItem(_ item: Item) {
        items.append(item)
    }
    
    func removeItem(_ item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }
}

class Favorites: ObservableObject {
    @Published var items: [Item] = []

    func addItem(_ item: Item) {
        if !items.contains(where: { $0.id == item.id }) {
            items.append(item)
        }
    }

    func removeItem(_ item: Item) {
        if let index = items.firstIndex(where: { $0.id == item.id }) {
            items.remove(at: index)
        }
    }
}



class ItemViewModel: ObservableObject {
    let item: Item
    @Published var imageData: Data?
    
    init(item: Item) {
        self.item = item
        loadImage()
    }
    
    func loadImage() {
        guard let url = URL(string: item.icon) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                DispatchQueue.main.async {
                    self.imageData = data
                }
            } else {
                print("Failed to fetch image: \(error?.localizedDescription ?? "Unknown error")")
            }
        }.resume()
    }
    
    func addToFavorites(_ favorites: Favorites) {
        favorites.addItem(item)
    }
    
    func addToCart(_ cart: Cart) {
        cart.addItem(item)
    }
}
