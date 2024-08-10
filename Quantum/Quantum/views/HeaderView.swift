import SwiftUI

struct HeaderView: View {
    var body: some View {
        HStack {
            Image(systemName: "leaf.circle.fill")
                .foregroundColor(.green)
            Text("Grocery tracker")
                .font(.headline)
            Spacer()
            Button(action: {}) {
                Text("Subscribe")
                    .foregroundColor(.white)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(Color.green)
                    .cornerRadius(15)
            }
        }
    }
}

struct HeaderView_Previews: PreviewProvider {
    static var previews: some View {
        HeaderView()
    }
}
