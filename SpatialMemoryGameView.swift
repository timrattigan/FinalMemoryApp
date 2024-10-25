// Views/SpatialMemory/SpatialMemoryGameView.swift
import SwiftUI

struct SpatialMemoryGameView: View {
    @State private var gridSize: Int = 3
    @State private var sequence: [Int] = []
    @State private var currentIndex: Int = 0
    @State private var level: Int = 1
    @State private var showSequence = true
    @State private var isGameOver = false
    @State private var selectedIndices: [Int] = []
    @ObservedObject var performanceVM = PerformanceViewModel()

    let totalLevels = 10

    var body: some View {
        VStack {
            Text("Level \(level)")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(Color.primaryColor)
                .padding()

            GridStack(rows: gridSize, columns: gridSize) { row, col in
                Button(action: {
                    if !showSequence {
                        let index = row * gridSize + col
                        handleUserSelection(at: index)
                    }
                }) {
                    let index = row * gridSize + col
                    Rectangle()
                        .foregroundColor(colorForCell(at: index))
                        .frame(width: 50, height: 50)
                        .cornerRadius(5)
                        .padding(2)
                }
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
        selectedIndices = []
        sequence = []
        currentIndex = 0
        showSequence = true

        // Increase grid size every few levels
        if level % 3 == 0 && gridSize < 6 {
            gridSize += 1
        }

        // Generate sequence
        let numberOfCells = gridSize * gridSize
        let numberOfHighlights = min(level + 2, numberOfCells)
        sequence = Array(0..<numberOfCells).shuffled().prefix(numberOfHighlights).map { $0 }

        // Display sequence
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            showSequence = false
        }
    }

    func handleUserSelection(at index: Int) {
        if sequence.contains(index) {
            if !selectedIndices.contains(index) {
                selectedIndices.append(index)
                if selectedIndices.count == sequence.count {
                    // Correct
                    level += 1
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        startLevel()
                    }
                }
            }
        } else {
            // Incorrect
            isGameOver = true
        }
    }

    func colorForCell(at index: Int) -> Color {
        if showSequence && sequence.contains(index) {
            return Color.accentColor
        } else if selectedIndices.contains(index) {
            return Color.accentColor
        } else {
            return Color.gray
        }
    }

    func savePerformanceData() {
        let entry = PerformanceEntry(
            id: UUID(),
            date: Date(),
            gameType: .spatialMemory,
            score: Double(level - 1)
        )
        performanceVM.addEntry(entry: entry)
    }
}

struct GridStack<Content: View>: View {
    let rows: Int
    let columns: Int
    let content: (Int, Int) -> Content

    var body: some View {
        VStack(spacing: 0) {
            ForEach(0 ..< rows, id: \.self) { row in
                HStack(spacing: 0) {
                    ForEach(0 ..< columns, id: \.self) { column in
                        self.content(row, column)
                    }
                }
            }
        }
    }
}

struct SpatialMemoryGameView_Previews: PreviewProvider {
    static var previews: some View {
        SpatialMemoryGameView()
    }
}
