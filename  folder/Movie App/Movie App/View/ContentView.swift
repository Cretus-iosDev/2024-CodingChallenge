import SwiftUI
import Kingfisher

struct ContentView: View {
    @State private var movies: [Movie] = []

    var body: some View {
        NavigationView {
            List(movies) { movie in
                NavigationLink(destination: MovieDetail(movie: movie)) {
                    HStack {
                        KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 100) // Adjust the size as needed
                            .cornerRadius(8) // Optional: Add corner radius for rounded corners

                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .lineLimit(2)

                            // Add additional details if needed
                        }
                        .padding(.horizontal)
                    }
                }
            }
            .navigationTitle("Movie List")
            .onAppear {
                MovieFetcher().fetchMovies { fetchedMovies in
                    movies = fetchedMovies
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
