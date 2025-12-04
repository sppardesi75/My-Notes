import SwiftUI
import SwiftData

@main
struct MyNotesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                // Initialize the model container for SwiftData
                .modelContainer(for: Note.self, inMemory: false)
        }
    }
}
