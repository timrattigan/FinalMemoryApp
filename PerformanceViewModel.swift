// ViewModels/PerformanceViewModel.swift
import Foundation
import CoreData

class PerformanceViewModel: ObservableObject {
    @Published var performanceData: [PerformanceEntry] = []

    private let viewContext = PersistenceController.shared.container.viewContext

    init() {
        fetchPerformanceData()
    }

    func addEntry(entry: PerformanceEntry) {
        let newEntry = PerformanceEntryEntity(context: viewContext)
        newEntry.id = entry.id
        newEntry.date = entry.date
        newEntry.gameType = entry.gameType.rawValue
        newEntry.score = entry.score

        saveContext()
        fetchPerformanceData()
    }

    func getEntries(for gameType: PerformanceEntry.GameType) -> [PerformanceEntry] {
        performanceData.filter { $0.gameType == gameType }
    }

    func getAllEntries() -> [PerformanceEntry] {
        performanceData
    }

    private func fetchPerformanceData() {
        let request: NSFetchRequest<PerformanceEntryEntity> = PerformanceEntryEntity.fetchRequest()
        do {
            let entities = try viewContext.fetch(request)
            performanceData = entities.map { entity in
                PerformanceEntry(
                    id: entity.id ?? UUID(),
                    date: entity.date ?? Date(),
                    gameType: PerformanceEntry.GameType(rawValue: entity.gameType ?? "") ?? .nBack,
                    score: entity.score
                )
            }
        } catch {
            print("Failed to fetch performance data: \(error)")
        }
    }

    private func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                // Handle the error appropriately in production
                print("Failed to save context: \(error)")
            }
        }
    }
}
