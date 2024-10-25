// Views/MainMenuView.swift
import SwiftUI
import FirebaseAuth

struct MainMenuView: View {
    @AppStorage("isLoggedIn") private var isLoggedIn = true

    var body: some View {
        NavigationView {
            VStack(spacing: 20) {
                Text("Cognitive Training App")
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.primaryColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Text("""
                Elevate your cognitive abilities by participating in diverse challenges designed to assess and improve mental performance. Track your progress in the Performance tab to identify strengths and areas for growth.
                """)
                    .font(.body)
                    .foregroundColor(Color.secondaryTextColor)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Spacer()

                VStack(spacing: 15) {
                    NavigationLink(destination: NBackDifficultyView()) {
                        Text("N-Back Test")
                            .modifier(MenuButtonStyle())
                    }
                    NavigationLink(destination: SequenceRecallView()) {
                        Text("Sequence Recall")
                            .modifier(MenuButtonStyle())
                    }
                    NavigationLink(destination: SpatialMemoryView()) {
                        Text("Spatial Memory")
                            .modifier(MenuButtonStyle())
                    }
                    NavigationLink(destination: PerformanceView()) {
                        Text("Performance")
                            .modifier(MenuButtonStyle())
                    }
                    NavigationLink(destination: SettingsView()) {
                        Text("Settings")
                            .modifier(MenuButtonStyle())
                    }
                    Button(action: logout) {
                        Text("Logout")
                            .modifier(MenuButtonStyle())
                    }
                }
                .padding(.horizontal)

                Spacer()
            }
            .navigationBarHidden(true)
            .background(Color.backgroundColor.edgesIgnoringSafeArea(.all))
        }
    }

    func logout() {
        do {
            try Auth.auth().signOut()
            isLoggedIn = false
        } catch {
            print("Error signing out: \(error.localizedDescription)")
        }
    }
}

struct MainMenuView_Previews: PreviewProvider {
    static var previews: some View {
        MainMenuView()
    }
}
