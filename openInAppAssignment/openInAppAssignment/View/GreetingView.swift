import SwiftUI

struct GreetingView: View {
    // Get the current date
    let currentDate = Date()
    
    // Define the calendar
    let calendar = Calendar.current
    
    // Define the date components to extract the hour
    let hour = Calendar.current.component(.hour, from: Date())
    
    // Define the greeting message based on the hour
    var greetingMessage: String {
        switch hour {
        case 0..<12:
            return "Good morning"
        case 12..<18:
            return "Good afternoon"
        default:
            return "Good evening"
        }
    }
    
    var body: some View {
        VStack(alignment: .leading,spacing: 8) {
            Text(greetingMessage)
                .font(Font.custom("Figtree", size: 16))
                .foregroundColor(Color(red: 0.60, green: 0.61, blue: 0.63))
                //.padding()
            Text("Rutik.M 👋")
                .font(.title)
        }
    }
}


#Preview {
    GreetingView()
}
