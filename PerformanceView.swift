// Views/Performance/PerformanceView.swift
import SwiftUI

struct PerformanceView: View {
    @ObservedObject var performanceVM = PerformanceViewModel()

    var body: some View {
        VStack {
            Text("Performance")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(Color.primaryColor)
                .padding()

            List {
                ForEach(PerformanceEntry.GameType.allCases, id: \.self) { gameType in
                    Section(header: Text(gameType.rawValue).font(.headline)) {
                        let entries = performanceVM.getEntries(for: gameType)
                        if entries.isEmpty {
                            Text("No data available")
                                .foregroundColor(Color.secondaryTextColor)
                        } else {
                            ForEach(entries) { entry in
                                HStack {
                                    Text(entry.formattedDate)
                                    Spacer()
                                    Text("Score: \(Int(entry.score))")
                                }
                            }
                        }
                    }
                }
            }
        }
        .background(Color.backgroundColor.edgesIgnoringSafeArea(.all))
    }
}

struct PerformanceView_Previews: PreviewProvider {
    static var previews: some View {
        PerformanceView()
    }
}
