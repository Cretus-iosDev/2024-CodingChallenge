import SwiftUI

struct CustomTabBar: View {
    @Binding var selectedIndex: Int
    
    var body: some View {
        ZStack {
            
            HStack {
                TabBarButton(imageName: "house", isSelected: selectedIndex == 0)
                
                    .onTapGesture {
                        selectedIndex = 0
                    }
                Spacer()
                TabBarButton(imageName: "list.bullet", isSelected: selectedIndex == 1)
                    .onTapGesture {
                        selectedIndex = 1
                    }
                Spacer()
                Spacer()
                TabBarButton(imageName: "bell", isSelected: selectedIndex == 3, showBadge: true)
                    .onTapGesture {
                        selectedIndex = 3
                    }
                Spacer()
                TabBarButton(imageName: "person", isSelected: selectedIndex == 4)
                    .onTapGesture {
                        selectedIndex = 4
                    }
            }
            .padding(.horizontal)
            .padding(.top, 15)
            .padding(.bottom, 15)
            .background(Color.black)
            .cornerRadius(25)
            .padding(.horizontal)
            .shadow(radius: 10)
            
            CameraButton(isSelected: selectedIndex == 2)
                .offset(y: -25)
                .onTapGesture {
                    selectedIndex = 2
                }
        }
    }
}


struct CustomTabBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomTabBar(selectedIndex: .constant(0))
            .previewLayout(.sizeThatFits)
            .padding()
    }
}
