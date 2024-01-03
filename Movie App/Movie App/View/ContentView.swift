import SwiftUI
import Kingfisher

struct ContentView: View {
    
    @State private var movies: [Movie] = []
    @State private var moviesDetails: [MovieDetails] = []
    
    var body: some View {
        NavigationView {
            List(0..<movies.count, id: \.self) { index in
                let movie = movies[index]
                let details = moviesDetails.indices.contains(index) ? moviesDetails[index] : nil
                
                NavigationLink(destination: MovieDetailView(movie: movie, details: details)) {
                    HStack {
                        KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)"))
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 100, height: 200)
                            .cornerRadius(10)
                        
                        VStack(alignment: .leading) {
                            Text(movie.title)
                                .font(.headline)
                                .foregroundColor(.primary)
                                .lineLimit(2)
                            
                            if let details = details {
                                Text(details.overview)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                            }
                        }
                        .padding(.horizontal)
                    }
                }
            }
        }
    
        .onAppear {
            MovieFetcher().fetchMovies { fetchedMovies in
                movies = fetchedMovies
                
                // Fetch movie details for each movie
                for movie in fetchedMovies {
                    MovieFetcher().fetchMovieDetails(movieId: movie.id) { details in
                        moviesDetails.append(details)
                    }
                }
            }
        }
    }
}


#Preview {
    ContentView()
}
