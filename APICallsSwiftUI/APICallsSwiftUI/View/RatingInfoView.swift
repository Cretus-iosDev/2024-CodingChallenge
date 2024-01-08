
import SwiftUI

struct RatingInfoView: View {

    let rating: String

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "star.fill")
                    .foregroundStyle(.yellow)
                
                Text(rating + " " + "Ratings")
                    .foregroundStyle(.secondary)
            }
            .font(.callout)
            
            Spacer()
            
            circleImage
            
            Spacer()
            
            Text("4.6k Reviews")
            
            Spacer()
            
            circleImage
            
            Spacer()
            
            Text("4.6k Sold")
        }
        .foregroundStyle(.secondary)
        .font(.callout)
    }

    var circleImage: some View {
        Image(systemName: "circle.fill")
            .resizable()
            .frame(width: 8, height: 8)
    }
}

struct RatingInfoView_Previews: PreviewProvider {
    static var previews: some View {
        RatingInfoView(rating: "4.5")
    }
}

