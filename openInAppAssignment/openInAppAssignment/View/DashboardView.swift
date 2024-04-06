import SwiftUI
struct DashboardView: View {
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 18)
                .fill(Color(red: 0.05, green: 0.44, blue: 1))
                .edgesIgnoringSafeArea(.all)
                .offset(y: -20)
            
            HStack {
                Text("Dashboard")
                    .font(Font.custom("Figtree", size: 24).weight(.semibold))
                    .foregroundColor(.white)
                
                Spacer()
                
                Button(action: {
                    // Action when button is tapped
                }) {
                    Image("Button")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 50, height: 50)
                        .foregroundColor(.white)
                       
                }
            }
            .padding(.horizontal,32)
        }
        //.background(Color(red: 0.96, green: 0.96, blue: 0.96))
        
    }
}


#Preview {
    DashboardView()
}
