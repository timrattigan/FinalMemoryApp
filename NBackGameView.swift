// Views/NBack/NBackGameView.swift
import SwiftUI

struct NBackGameView: View {
    let level: Int
    @State private var sequence: [String] = []
    @State private var currentStimulus: String = ""
    @State private var currentIndex: Int = 0
    @State private var score: Int = 0
    @State private var isGameOver = false
    @State private var showFeedback = false
    @State private var feedbackText = ""
    @State private var feedbackColor = Color.green
    @ObservedObject var performanceVM = PerformanceViewModel()

    let totalTrials = 20
    let stimuli = ["A", "B", "C", "D", "E", "F", "G", "H"]

    var body: some View {
        VStack {
            Text("Level \(level)-Back")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.primaryColor)
                .padding()

            Text(currentStimulus)
                .font(.system(size: 80, weight: .bold))
                .foregroundColor(Color.primaryColor)
                .padding()

            Text("Score: \(score)")
                .font(.headline)
                .foregroundColor(Color.secondaryTextColor)
                .padding()

            if showFeedback {
                Text(feedbackText)
                    .font(.headline)
                    .foregroundColor(feedbackColor)
                    .padding()
            }

            Spacer()

            HStack(spacing: 20) {
                Button(action: {
                    userResponse(isMatch: true)
                }) {
                    Text("Match")
                        .modifier(ResponseButtonStyle(color: .green))
                }
                .disabled(currentIndex <= level)

                Button(action: {
                    userResponse(isMatch: false)
                }) {
                    Text("No Match")
                        .modifier(ResponseButtonStyle(color: .red))
                }
                .disabled(currentIndex <= level)
            }
            .padding(.horizontal)

            Spacer()
        }
        .onAppear(perform: startGame)
        .navigationBarTitle("", displayMode: .inline)
        .alert(isPresented: $isGameOver) {
            Alert(
                title: Text("Game Over"),
                message: Text("Your final score is \(score)."),
                dismissButton: .default(Text("OK")) {
                    savePerformanceData()
                }
            )
        }
        .background(Color.backgroundColor.edgesIgnoringSafeArea(.all))
    }

    func startGame() {
        sequence = []
        currentIndex = 0
        score = 0
        presentNextStimulus()
    }

    func presentNextStimulus() {
        if currentIndex >= totalTrials {
            isGameOver = true
            return
        }

        let newStimulus = stimuli.randomElement() ?? "A"
        sequence.append(newStimulus)
        currentStimulus = newStimulus
        currentIndex += 1
        showFeedback = false

        // Proceed to next stimulus after a delay
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            presentNextStimulus()
        }
    }

    func userResponse(isMatch: Bool) {
        guard currentIndex > level else { return }

        let current = sequence[currentIndex - 1]
        let previous = sequence[currentIndex - level - 1]

        let actualMatch = current == previous

        if isMatch == actualMatch {
            score += 1
            feedbackText = "Correct!"
            feedbackColor = .green
        } else {
            score -= 1
            feedbackText = "Incorrect"
            feedbackColor = .red
        }
        showFeedback = true
    }

    func savePerformanceData() {
        let entry = PerformanceEntry(
            id: UUID(),
            date: Date(),
            gameType: .nBack,
            score: Double(score)
        )
        performanceVM.addEntry(entry: entry)
    }
}

struct NBackGameView_Previews: PreviewProvider {
    static var previews: some View {
        NBackGameView(level: 2)
    }
}
