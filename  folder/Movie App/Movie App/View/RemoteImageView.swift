import SwiftUI
import Kingfisher

struct RemoteImageView: View {
    let urlString: String
    
    var body: some View {
        KFImage(URL(string: urlString))
            .resizable()
            .placeholder {
                Color.gray
            }
            .aspectRatio(contentMode: .fit)
    }
}



