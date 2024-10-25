// Models/PerformanceEntry.swift
import Foundation

struct PerformanceEntry: Identifiable, Codable {
    let id: UUID
    let date: Date
    let gameType: GameType
    let score: Double

    enum GameType: String, CaseIterable, Codable {
        case nBack = "N-Back Test"
        case sequenceRecall = "Sequence Recall"
        case spatialMemory = "Spatial Memory"
    }

    var formattedDate: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMM dd, yyyy"
        return formatter.string(from: date)
    }
}
