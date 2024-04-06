import SwiftUI

struct SegmentView: View {
    @State var preselectedIndex = 0
    
    var body: some View {
        VStack {
            CustomSegmentedControl(preselectedIndex: $preselectedIndex, options: ["Top Links", "Recent Links"])
            
            // Display content based on selected tab
            if preselectedIndex == 0 {
                // Content for "Top Links" tab
                SampleLinkItemView()

            } else {
                // Content for "Recent Links" tab
                RecentLinkView()
            }
        }
    }
}

struct CustomSegmentedControl: View {
    @Binding var preselectedIndex: Int
    var options: [String]
    let selectedColor = Color.blue
    
    var body: some View {
        HStack(spacing: 15) {
            ForEach(options.indices, id: \.self) { index in
                let isSelected = preselectedIndex == index
                Button(action: {
                    withAnimation(.interactiveSpring(response: 0.2, dampingFraction: 2, blendDuration: 0.5)) {
                        preselectedIndex = index
                    }
                }) {
                    Text(options[index])
                        .fontWeight(isSelected ? .bold : .regular)
                        .foregroundColor(isSelected ? .white : .gray)
                        .frame(width: 121)
                        .padding(12)
                        .background(isSelected ? selectedColor : Color.clear)
                        .cornerRadius(50)
                }
                .buttonStyle(PlainButtonStyle())
            }
            SearchButton()
        }
        .frame(height: 10)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        SegmentView()
    }
}
