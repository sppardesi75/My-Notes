import Foundation

struct FileSystemManager {
    static func getDocumentsDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return paths[0]
    }
    
    static func saveNote(title: String, content: String) -> Bool {
        let filename = getDocumentsDirectory().appendingPathComponent("\(title).txt")
        do {
            try content.write(to: filename, atomically: true, encoding: .utf8)
            return true
        } catch {
            print("Failed to save note: \(error.localizedDescription)")
            return false
        }
    }
    
    static func loadNotes() -> [String] {
        let directory = getDocumentsDirectory()
        do {
            let fileURLs = try FileManager.default.contentsOfDirectory(at: directory, includingPropertiesForKeys: nil)
            // Filter only text files
            let txtFiles = fileURLs.filter { $0.pathExtension == "txt" }
            // Return file names without extension
            return txtFiles.map { $0.deletingPathExtension().lastPathComponent }
        } catch {
            print("Error loading notes: \(error.localizedDescription)")
            return []
        }
    }
    
    static func loadNoteContent(title: String) -> String {
        let filename = getDocumentsDirectory().appendingPathComponent("\(title).txt")
        do {
            let content = try String(contentsOf: filename, encoding: .utf8)
            return content
        } catch {
            print("Error reading note: \(error.localizedDescription)")
            return ""
        }
    }
    
    static func deleteNote(title: String) -> Bool {
        let filename = getDocumentsDirectory().appendingPathComponent("\(title).txt")
        do {
            try FileManager.default.removeItem(at: filename)
            return true
        } catch {
            print("Error deleting note: \(error.localizedDescription)")
            return false
        }
    }
}
