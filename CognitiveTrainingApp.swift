// CognitiveTrainingApp.swift
import SwiftUI
import FirebaseCore

@main
struct CognitiveTrainingApp: App {
    init() {
        FirebaseApp.configure()
    }

    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
