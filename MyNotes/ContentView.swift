import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    
    var body: some View {
        TabView {
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gear")
                }
            
            FileNotesView()
                .tabItem {
                    Label("File Notes", systemImage: "doc.text")
                }
            
            SwiftDataNotesView()
                .tabItem {
                    Label("SwiftData Notes", systemImage: "note.text")
                }
        }
        // This ensures the whole app follows the user’s dark/light mode setting.
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
