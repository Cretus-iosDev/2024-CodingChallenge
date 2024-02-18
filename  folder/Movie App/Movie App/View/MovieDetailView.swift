import SwiftUI
import Kingfisher

struct MovieDetail: View {
    let movie: Movie
    @State private var movieDetails: MovieDetails? = nil
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(movie.title)
                    .font(.title)
                KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(height: 300)
               
                Text("OverView: ")
                    .font(.headline)
                VStack {
                    Text("\(movieDetails?.overview ?? "")")
                }
                
                
                HStack {
                    Text(String(format: "Rating: %.1f", movieDetails?.vote_average ?? 0.0))
                        .font(.headline)
                    ForEach(1...5, id: \.self) { index in
                        let ratingValue = movieDetails?.vote_average ?? 0
                        let starRating = (ratingValue / 2)
                        
                        if Double(index) <= starRating {
                            Image(systemName: "star.fill")
                                .foregroundColor(.yellow)
                        } else if Double(index - 1) < starRating && starRating < Double(index) {
                            Image(systemName: "star.leadinghalf.fill")
                                .foregroundColor(.yellow)
                        } else {
                            Image(systemName: "star")
                                .foregroundColor(.yellow)
                        }
                    }
                    
                }
                .padding(.top, 4)
                HStack {
                
                    Text("Release Date: \(movieDetails?.release_date ?? "")")
                        .font(.headline)
                }
                Text("Popularity❤️: \(movieDetails?.popularity ?? 0.0)")
                    .font(.headline)

                Spacer()
            }
            .padding()
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: backButton)
            .onAppear {
                fetchMovieDetails()
            }
        }
    }
    
    private var backButton: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrow.left.circle.fill")
                .font(.title)
        }
    }
    
    private func fetchMovieDetails() {
        guard let apiKey = Bundle.main.object(forInfoDictionaryKey: "Test Key") as? String else {
            print("TMDB API Key missing")
            return
        }
        
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movie.id)?api_key=\(apiKey)&append_to_response=credits")!
        URLSession.shared.dataTask(with: url) { data, _, error in
            if let data = data {
                do {
                    let movieDetails = try JSONDecoder().decode(MovieDetails.self, from: data)
                    DispatchQueue.main.async {
                        self.movieDetails = movieDetails
                    }
                } catch {
                    print("Error decoding JSON: \(error)")
                }
            }
        }.resume()
    }
}

struct MovieDetail_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMovie = Movie(id: 1, title: "Sample Movie", posterPath: "/samplePoster.jpg")
        return MovieDetail(movie: sampleMovie)
    }
}

