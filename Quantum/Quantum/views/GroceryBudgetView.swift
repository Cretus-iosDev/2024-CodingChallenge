import SwiftUI

struct GroceryBudgetView: View {
    let monthlyBudget: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Grocery budget")
                .font(.headline)
                .padding(.bottom, 8)
            
            HStack {
                Circle()
                    .fill(Color.white)
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "bag.fill")
                            .foregroundColor(.green)
                    )
                
                VStack(alignment: .leading) {
                    Text("€\(monthlyBudget)")
                        .font(.title2)
                        .fontWeight(.bold)
                        .foregroundColor(.white.opacity(0.8))
                    
                    Text("Your monthly budget")
                        .font(.subheadline)
                        .foregroundColor(.white.opacity(0.8))
                }
                .padding(.leading, 8)
                
                Spacer()
                
                Image(systemName: "chevron.right")
                    .foregroundColor(.white)
                    .padding(.trailing, 8)
            }
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.green)
            )
        }
        .padding()
    }
}

#Preview {
    GroceryBudgetView(monthlyBudget: 39)
}
