import SwiftData
import Foundation

@Model
class Note: Identifiable {
    var id: UUID = UUID() // Automatically generated unique ID
    var title: String
    var content: String
    var createdAt: Date
    
    init(title: String, content: String) {
        self.title = title
        self.content = content
        self.createdAt = Date()
    }
}
