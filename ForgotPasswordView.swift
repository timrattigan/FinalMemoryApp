// Views/Auth/ForgotPasswordView.swift
import SwiftUI
import FirebaseAuth

struct ForgotPasswordView: View {
    @State private var email = ""
    @State private var showConfirmation = false
    @State private var showError = false
    @State private var errorMessage = ""

    var body: some View {
        VStack(spacing: 20) {
            Text("Reset Password")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.primaryColor)
                .padding(.top, 50)

            TextField("Email Address", text: $email)
                .autocapitalization(.none)
                .keyboardType(.emailAddress)
                .padding()
                .background(Color(.secondarySystemBackground))
                .cornerRadius(10)
                .padding(.horizontal)

            Button(action: resetPassword) {
                Text("Send Reset Link")
                    .modifier(MenuButtonStyle())
            }
            .padding(.horizontal)

            if showConfirmation {
                Text("A password reset link has been sent to your email.")
                    .foregroundColor(.green)
                    .padding(.horizontal)
            }

            if showError {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding(.horizontal)
            }

            Spacer()
        }
        .navigationBarTitle("Forgot Password", displayMode: .inline)
        .background(Color.backgroundColor.edgesIgnoringSafeArea(.all))
    }

    func resetPassword() {
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                errorMessage = error.localizedDescription
                showError = true
                showConfirmation = false
            } else {
                showConfirmation = true
                showError = false
            }
        }
    }
}

struct ForgotPasswordView_Previews: PreviewProvider {
    static var previews: some View {
        ForgotPasswordView()
    }
}
