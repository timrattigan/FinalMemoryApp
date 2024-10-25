// Views/SequenceRecall/SequenceRecallView.swift
import SwiftUI

struct SequenceRecallView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("Sequence Recall")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.primaryColor)
                .padding()

            Text("""
            Improve your memory by recalling sequences of numbers that increase in length as you progress.
            """)
                .font(.body)
                .foregroundColor(Color.secondaryTextColor)
                .multilineTextAlignment(.center)
                .padding(.horizontal)

            Spacer()

            NavigationLink(destination: SequenceRecallGameView()) {
                Text("Start Game")
                    .modifier(MenuButtonStyle())
            }
            .padding(.horizontal)

            Spacer()
        }
        .navigationBarTitle("Sequence Recall", displayMode: .inline)
        .background(Color.backgroundColor.edgesIgnoringSafeArea(.all))
    }
}

struct SequenceRecallView_Previews: PreviewProvider {
    static var previews: some View {
        SequenceRecallView()
    }
}
