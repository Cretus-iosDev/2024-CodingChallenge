import Foundation
import Combine

class DashboardViewModel: ObservableObject {
    @Published var dashboardResponse: Json4Swift_Base?
    @Published var isLoading = false
    @Published var error: Error?
    private var cancellables = Set<AnyCancellable>()

    func fetchDashboardData() {
        isLoading = true
        guard let apiUrl = URL(string: "https://api.inopenapp.com/api/v1/dashboardNew") else {
            fatalError("Invalid API URL")
        }

        var request = URLRequest(url: apiUrl)
        request.httpMethod = "GET"
        let token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6MjU5MjcsImlhdCI6MTY3NDU1MDQ1MH0.dCkW0ox8tbjJA2GgUx2UEwNlbTZ7Rr38PVFJevYcXFI"
        request.setValue("Bearer \(token)", forHTTPHeaderField: "Authorization")

        URLSession.shared.dataTaskPublisher(for: request)
            .receive(on: DispatchQueue.main)
            .map(\.data)
            .decode(type: Json4Swift_Base.self, decoder: JSONDecoder())
            .sink { completion in
                switch completion {
                case .finished:
                    self.isLoading = false
                case .failure(let error):
                    self.isLoading = false
                    self.error = error
                }
            } receiveValue: { response in
                self.dashboardResponse = response
            }
            .store(in: &cancellables)
        
        
        
    }
}





