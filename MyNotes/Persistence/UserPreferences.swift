import Foundation

struct UserPreferences {
    static let displayNameKey = "displayName"
    static let isDarkModeKey = "isDarkMode"
    static let defaultCategoryKey = "defaultCategory"
    
    static func saveDisplayName(_ name: String) {
        UserDefaults.standard.set(name, forKey: displayNameKey)
    }
    
    static func getDisplayName() -> String {
        return UserDefaults.standard.string(forKey: displayNameKey) ?? ""
    }
    
    static func saveIsDarkMode(_ isDarkMode: Bool) {
        UserDefaults.standard.set(isDarkMode, forKey: isDarkModeKey)
    }
    
    static func getIsDarkMode() -> Bool {
        return UserDefaults.standard.bool(forKey: isDarkModeKey)
    }
    
    static func saveDefaultCategory(_ category: String) {
        UserDefaults.standard.set(category, forKey: defaultCategoryKey)
    }
    
    static func getDefaultCategory() -> String {
        return UserDefaults.standard.string(forKey: defaultCategoryKey) ?? ""
    }
}
