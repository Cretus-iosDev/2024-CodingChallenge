import SwiftUI

struct CameraButton: View {
    let isSelected: Bool
    
    var body: some View {
        ZStack {
            Circle()
                .foregroundColor(isSelected ? .green : .gray)
                .frame(width: 60, height: 60)
            Image(systemName: "camera")
                .foregroundColor(.white)
                .font(.title)
        }
    }
}


