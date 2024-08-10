import SwiftUI

struct TabBarButton: View {
    let imageName: String
    let isSelected: Bool
    var showBadge: Bool = false
    
    var body: some View {
        VStack {
            if showBadge {
                Image(systemName: imageName)
                    .foregroundColor(isSelected ? .green : .gray)
                    .overlay(
                        Circle()
                            .fill(Color.red)
                            .frame(width: 10, height: 10)
                            .offset(x: 10, y: -10)
                    )
            } else {
                Image(systemName: imageName)
                    .foregroundColor(isSelected ? .green : .gray)
            }
        }
    }
}

struct TabBarButton_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            HStack {
                TabBarButton(imageName: "house", isSelected: true)
                TabBarButton(imageName: "list.bullet", isSelected: false)
                TabBarButton(imageName: "bell", isSelected: false, showBadge: true)
                TabBarButton(imageName: "person", isSelected: false)
            }
            .padding()
            .background(Color.black)
            .previewLayout(.sizeThatFits)
        }
    }
}
