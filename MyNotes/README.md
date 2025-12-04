
# MyNotesApp

## Overview
MyNotesApp is a simple note-taking application that demonstrates three different data persistence methods in iOS:
- **UserDefaults:** Stores user preferences (display name, dark mode toggle, default note category).
- **FileSystem:** Saves, lists, opens, and deletes text-based notes (as `.txt` files) using the device’s document directory.
- **SwiftData:** Manages notes using a data model that supports Create, Read, Update, and Delete (CRUD) operations with SwiftData's new framework.

The app features an adaptive and visually appealing UI that automatically adjusts to dark and light modes based on the user’s preference.

## Project Structure
```
MyNotesApp/
├── MyNotesApp.swift                // App entry point, configures SwiftData container
├── ContentView.swift               // Root view with TabView for navigating different screens
├── Models/
│   └── Note.swift                  // SwiftData model for a note (title, content, createdAt, id)
├── Persistence/
│   ├── UserPreferences.swift       // UserDefaults helper for saving/retrieving settings
│   └── FileSystemManager.swift     // File system helper for managing text notes
├── Views/
│   ├── SettingsView.swift          // UI for setting user preferences (using @AppStorage)
│   ├── FileNotesView.swift         // UI for file-based note creation and management
│   └── SwiftDataNotesView.swift    // UI for SwiftData note management (CRUD, validations)
└── README.md                       // This file
```

## Implementation Details

### Part 1: UserDefaults Implementation
- **What It Does:**  
  The Settings screen lets users set their display name, toggle dark mode, and specify a default note category.
- **How It Works:**  
  - **UserPreferences.swift:** Contains helper methods to save and retrieve values from UserDefaults.
  - **SettingsView.swift:** Uses the `@AppStorage` property wrapper to bind UI controls directly to the underlying UserDefaults keys. Changes made in the settings are automatically saved and persist between app launches.
  - **Dark Mode Integration:**  
    The root `ContentView` uses `.preferredColorScheme(isDarkMode ? .dark : .light)` so that when the user toggles dark mode, the app’s theme changes immediately.

### Part 2: FileSystem Implementation
- **What It Does:**  
  Users can create a text note with a title and content, save it to the device’s document directory, list saved notes, open them to view content, and delete them.
- **How It Works:**  
  - **FileSystemManager.swift:**  
    - `saveNote(title:content:)` writes note content to a `.txt` file.
    - `loadNotes()` retrieves the list of saved note titles.
    - `loadNoteContent(title:)` reads note content from the file.
    - `deleteNote(title:)` deletes the specified note.
  - **FileNotesView.swift:**  
    - Provides a form for entering the note title and content.
    - Validates that the note title is not empty before saving.
    - Lists all saved notes, and allows users to tap a note to load its content.
    - Implements swipe-to-delete to remove notes.

### Part 3: SwiftData Implementation
- **What It Does:**  
  Offers a modern note-taking interface where users can add, edit, and delete notes stored using SwiftData.
- **How It Works:**  
  - **Models/Note.swift:**  
    The `Note` model is annotated with `@Model` (SwiftData) and includes properties for `title`, `content`, `createdAt`, and a unique identifier (`id`).
  - **SwiftDataNotesView.swift:**  
    - Uses the `@Query` property wrapper to fetch and sort notes by creation date (newest first).
    - Provides a toolbar button to add new notes.
    - Allows deletion of notes via swipe-to-delete.
  - **NoteDetailView (within SwiftDataNotesView.swift):**  
    - Allows users to edit note details with inline validations ensuring that a note’s title is not empty.
    - Uses `@Bindable` to automatically update the model as changes are made.

### UI Enhancements & Validations
- **Adaptive Colors & Themes:**  
  The app uses system-adaptive colors (e.g., `UIColor.systemBackground`, `UIColor.secondarySystemBackground`) to ensure a seamless transition between dark and light modes.
- **Visual Styling:**  
  Rounded corners, shadows, gradients, and icons enhance the UI, making it modern and user-friendly.
- **Validations:**  
  - In the FileNotesView, saving a note requires a non-empty title.
  - In the SwiftData note detail view, an alert is shown if the note title is emptied (only whitespace).

