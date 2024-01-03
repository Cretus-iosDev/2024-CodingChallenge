import SwiftUI
import Kingfisher

struct MovieDetailView: View {
    let movie: Movie
    let details: MovieDetails?
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text(movie.title)
                    .font(.title)
                    .foregroundColor(.primary)
                
                KFImage(URL(string: "https://image.tmdb.org/t/p/w500\(movie.posterPath)"))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(10)
                    .padding()
                
                Text("Overview: ")
                    .font(.headline)
                VStack {
                    Text("\(details?.overview ?? "")")
                        .foregroundColor(.secondary)
                }
                
                HStack {
                    Text("Rating: \(details?.vote_average ?? 0.0)")
                        .font(.headline)
                    ForEach(1...5, id: \.self) { index in
                        let ratingValue = details?.vote_average ?? 0
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
                    Text("Release Date: \(details?.release_date ?? "")")
                        .font(.headline)
                }
                
                Text("Popularity❤️: \(details?.popularity ?? 0.0)")
                    .font(.headline)
                
                Spacer()
            }
            .padding()
        }
        .navigationTitle("Movie Details")
    }
}

struct MovieDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let sampleMovie = Movie(id: 1, title: "Sample Movie", posterPath: "/samplePoster.jpg")
        let sampleDetails = MovieDetails(overview: "Sample overview", vote_average: 7.5, release_date: "2023-01-01", popularity: 123.45)
        return MovieDetailView(movie: sampleMovie, details: sampleDetails)
    }
}
