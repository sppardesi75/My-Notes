import SwiftUI

struct SettingsView: View {
    @AppStorage("displayName") var displayName: String = ""
    @AppStorage("isDarkMode") var isDarkMode: Bool = false
    @AppStorage("defaultCategory") var defaultCategory: String = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                // Adaptive gradient background using system colors.
                LinearGradient(
                    gradient: Gradient(colors: [
                        Color(UIColor.systemTeal).opacity(0.3),
                        Color(UIColor.systemPurple).opacity(0.3)
                    ]),
                    startPoint: .topLeading,
                    endPoint: .bottomTrailing
                )
                .ignoresSafeArea()
                
                Form {
                    Section(header: Text("User Preferences").font(.headline)) {
                        HStack {
                            Image(systemName: "person.fill")
                                .foregroundColor(.blue)
                            TextField("Display Name", text: $displayName)
                        }
                        
                        Toggle(isOn: $isDarkMode) {
                            Label("Dark Mode", systemImage: "moon.fill")
                        }
                        
                        HStack {
                            Image(systemName: "folder.fill")
                                .foregroundColor(.purple)
                            TextField("Default Category", text: $defaultCategory)
                        }
                    }
                }
                // Use an adaptive background color for the form.
                .background(Color(UIColor.secondarySystemBackground))
                .cornerRadius(12)
                .padding()
            }
            .navigationTitle("Settings")
        }
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
