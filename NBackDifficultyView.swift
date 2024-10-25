// Views/NBack/NBackDifficultyView.swift
import SwiftUI

struct NBackDifficultyView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("N-Back Test")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.primaryColor)
                .padding()

            Text("""
            Strengthen your working memory and cognitive flexibility with the N-Back Test, a scientifically validated exercise.
            """)
                .font(.body)
                .foregroundColor(Color.secondaryTextColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            VStack(spacing: 15) {
                ForEach(1...5, id: \.self) { level in
                    NavigationLink(destination: NBackGameView(level: level)) {
                        Text("Level \(level)")
                            .modifier(MenuButtonStyle())
                    }
                }
            }
            .padding(.horizontal)

            Spacer()
        }
        .navigationBarTitle("N-Back Test", displayMode: .inline)
        .background(Color.backgroundColor.edgesIgnoringSafeArea(.all))
    }
}

struct NBackDifficultyView_Previews: PreviewProvider {
    static var previews: some View {
        NBackDifficultyView()
    }
}
