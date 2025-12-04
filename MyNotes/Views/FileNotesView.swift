import SwiftUI

struct FileNotesView: View {
    @State private var noteTitle: String = ""
    @State private var noteContent: String = ""
    @State private var savedNotes: [String] = []
    @State private var showingAlert = false
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationView {
            ZStack {
                // Adaptive background
                Color(UIColor.systemBackground)
                    .ignoresSafeArea()
                
                VStack {
                    Form {
                        Section(header: Text("Create a New Note").font(.headline)) {
                            TextField("Title", text: $noteTitle)
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                            TextEditor(text: $noteContent)
                                .frame(height: 150)
                                .overlay(
                                    RoundedRectangle(cornerRadius: 8)
                                        .stroke(Color(UIColor.separator))
                                )
                            
                            Button(action: {
                                // Validate that the title is not empty.
                                guard !noteTitle.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
                                    alertMessage = "Please enter a title for the note."
                                    showingAlert = true
                                    return
                                }
                                
                                // Optionally, validate content as well.
                                let success = FileSystemManager.saveNote(title: noteTitle, content: noteContent)
                                if success {
                                    alertMessage = "Note saved successfully!"
                                    refreshNotes()
                                    noteTitle = ""
                                    noteContent = ""
                                } else {
                                    alertMessage = "Failed to save note."
                                }
                                showingAlert = true
                            }) {
                                HStack {
                                    Spacer()
                                    Text("Save Note")
                                        .foregroundColor(.white)
                                    Spacer()
                                }
                                .padding()
                                .background(Color.accentColor)
                                .cornerRadius(8)
                            }
                        }
                        
                        Section(header: Text("Saved Notes").font(.headline)) {
                            List {
                                ForEach(savedNotes, id: \.self) { title in
                                    Button(action: {
                                        noteTitle = title
                                        noteContent = FileSystemManager.loadNoteContent(title: title)
                                    }) {
                                        HStack {
                                            Image(systemName: "doc.text")
                                                .foregroundColor(.accentColor)
                                            Text(title)
                                        }
                                        .padding(8)
                                        .background(
                                            RoundedRectangle(cornerRadius: 8)
                                                .fill(Color(UIColor.secondarySystemBackground))
                                        )
                                        .shadow(color: Color.black.opacity(0.1), radius: 2, x: 0, y: 2)
                                    }
                                    .buttonStyle(PlainButtonStyle())
                                }
                                .onDelete(perform: deleteNote)
                            }
                        }
                    }
                }
                .padding()
            }
            .navigationTitle("File Notes")
            .onAppear(perform: refreshNotes)
            .alert(isPresented: $showingAlert) {
                Alert(title: Text(alertMessage))
            }
        }
    }
    
    func refreshNotes() {
        savedNotes = FileSystemManager.loadNotes()
    }
    
    func deleteNote(at offsets: IndexSet) {
        offsets.forEach { index in
            let title = savedNotes[index]
            if FileSystemManager.deleteNote(title: title) {
                alertMessage = "Deleted \(title)"
            } else {
                alertMessage = "Failed to delete \(title)"
            }
        }
        refreshNotes()
    }
}

struct FileNotesView_Previews: PreviewProvider {
    static var previews: some View {
        FileNotesView()
    }
}
