

import SwiftUI

struct ResetPasswordView: View {
    @State private var emailAddress: String = ""
    var body: some View {
           NavigationView {
               VStack(alignment: .center, spacing: 20) {
                   TextField("Enter your email", text: $emailAddress)
                       .padding()
                       .textFieldStyle(RoundedBorderTextFieldStyle())
                       .autocapitalization(.none)
                       .keyboardType(.emailAddress)
                   
                   Button(action: {
                       // Add your password reset logic here
                       print("Password reset initiated for: \(emailAddress)")
                   }) {
                       Text("Reset Password")
                           .frame(minWidth: 0, maxWidth: .infinity)
                           .padding()
                           .foregroundColor(.white)
                           .background(Color.blue)
                           .cornerRadius(10)
                   }
                   .padding(.horizontal)
                   
//                   NavigationLink(
//                     //  destination: LoginView(), // Assuming LoginView is your login screen
//                      // label: {
//                           Text("Back to Login")
//                               .foregroundColor(.blue)
//                               .padding()
//                       }
//                   )
               }
               .padding()
               .navigationBarTitle("Reset Password", displayMode: .inline)
           }
       }
}

#Preview {
    ResetPasswordView()
}
