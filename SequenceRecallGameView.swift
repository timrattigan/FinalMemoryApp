// Views/SequenceRecall/SequenceRecallGameView.swift
import SwiftUI

struct SequenceRecallGameView: View {
    @State private var sequence: [Int] = []
    @State private var userInput: String = ""
    @State private var level: Int = 1
    @State private var showSequence = true
    @State private var isGameOver = false
    @State private var showFeedback = false
    @State private var feedbackText = ""
    @State private var feedbackColor = Color.green
    @ObservedObject var performanceVM = PerformanceViewModel()

    var body: some View {
        VStack(spacing: 20) {
            Text("Level \(level)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.primaryColor)
                .padding()

            if showSequence {
                Text(sequence.map { "\($0)" }.joined(separator: " "))
                    .font(.largeTitle)
                    .fontWeight(.bold)
                    .foregroundColor(Color.primaryColor)
                    .padding()
                    .onAppear(perform: hideSequenceAfterDelay)
            } else {
                TextField("Enter the sequence", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .font(.title2)
                    .padding(.horizontal)
                    .keyboardType(.numberPad)
            }

            if showFeedback {
                Text(feedbackText)
                    .font(.headline)
                    .foregroundColor(feedbackColor)
                    .padding()
            }

            Spacer()

            if !showSequence {
                Button(action: checkUserInput) {
                    Text("Submit")
                        .modifier(MenuButtonStyle())
                }
                .padding(.horizontal)
            }

            Spacer()
        }
        .onAppear(perform: startLevel)
        .navigationBarTitle("", displayMode: .inline)
        .alert(isPresented: $isGameOver) {
            Alert(
                title: Text("Game Over"),
                message: Text("You reached level \(level)."),
                dismissButton: .default(Text("OK")) {
                    savePerformanceData()
                }
            )
        }
        .background(Color.backgroundColor.edgesIgnoringSafeArea(.all))
    }

    func startLevel() {
        sequence = (0..<level).map { _ in Int.random(in: 0...9) }
        showSequence = true
        userInput = ""
        showFeedback = false
    }

    func hideSequenceAfterDelay() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showSequence = false
        }
    }

    func checkUserInput() {
        let userSequence = userInput.compactMap { Int(String($0)) }
        if userSequence == sequence {
            feedbackText = "Correct!"
            feedbackColor = .green
            showFeedback = true
            level += 1
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                startLevel()
            }
        } else {
            feedbackText = "Incorrect"
            feedbackColor = .red
            showFeedback = true
            isGameOver = true
        }
    }

    func savePerformanceData() {
        let entry = PerformanceEntry(
            id: UUID(),
            date: Date(),
            gameType: .sequenceRecall,
            score: Double(level - 1)
        )
        performanceVM.addEntry(entry: entry)
    }
}

struct SequenceRecallGameView_Previews: PreviewProvider {
    static var previews: some View {
        SequenceRecallGameView()
    }
}
