import SwiftUI
import SwiftData

struct SwiftDataNotesView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: \Note.createdAt, order: .reverse) var notes: [Note]
    
    var body: some View {
        NavigationView {
            ZStack {
                Color(UIColor.systemBackground)
                    .ignoresSafeArea()
                
                List {
                    ForEach(notes) { note in
                        NavigationLink(destination: NoteDetailView(note: note)) {
                            VStack(alignment: .leading, spacing: 4) {
                                Text(note.title)
                                    .font(.headline)
                                    .foregroundColor(.primary)
                                Text(note.createdAt, format: .dateTime)
                                    .font(.caption)
                                    .foregroundColor(.secondary)
                            }
                            .padding()
                            .background(
                                RoundedRectangle(cornerRadius: 10)
                                    .fill(Color(UIColor.secondarySystemBackground))
                            )
                            .shadow(color: Color.black.opacity(0.1), radius: 3, x: 0, y: 2)
                        }
                    }
                    .onDelete(perform: deleteNotes)
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("SwiftData Notes")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: addNote) {
                        Label("Add Note", systemImage: "plus.circle.fill")
                    }
                }
            }
        }
    }
    
    private func addNote() {
        // Create a new note with a default title; user can edit later.
        let newNote = Note(title: "New Note", content: "")
        modelContext.insert(newNote)
    }
    
    private func deleteNotes(offsets: IndexSet) {
        for index in offsets {
            modelContext.delete(notes[index])
        }
    }
}

struct NoteDetailView: View {
    @Bindable var note: Note
    @State private var showingValidationAlert = false
    
    var body: some View {
        Form {
            Section(header: Text("Title").font(.headline)) {
                TextField("Title", text: $note.title)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .onChange(of: note.title) { newValue in
                        // Basic validation: ensure title is not empty.
                        if newValue.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                            showingValidationAlert = true
                        }
                    }
            }
            Section(header: Text("Content").font(.headline)) {
                TextEditor(text: $note.content)
                    .frame(height: 150)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color(UIColor.separator))
                    )
            }
            Section(header: Text("Created At").font(.headline)) {
                Text(note.createdAt, format: .dateTime)
            }
        }
        .navigationTitle("Note Details")
        .alert(isPresented: $showingValidationAlert) {
            Alert(title: Text("Invalid Title"), message: Text("The note title cannot be empty."), dismissButton: .default(Text("OK")))
        }
    }
}

struct SwiftDataNotesView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftDataNotesView()
    }
}
