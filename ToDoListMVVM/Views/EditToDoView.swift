//
//  EditToDoView.swift
//  ToDoListMVVM
//
//  Created by Emanuel Gonzalez on 12/6/24.
//

import SwiftUI

struct EditToDoView: View {
    @Binding var todo: ToDo
    @Environment(\.dismiss) private var dismiss
    @Environment(\.colorScheme) private var colorScheme

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("To-Do Details")) {
                    TextField("Title", text: $todo.title)
                }
            }
            .navigationTitle("Edit To-Do")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        dismiss()
                    }
                    .foregroundColor(colorScheme == .dark ? .yellow : .accentColor)
                }
            }
        }
    }
}

struct EditToDoView_Previews: PreviewProvider {
    @State static var sampleToDo = ToDo(title: "Sample To-Do")

    static var previews: some View {
        Group {
            EditToDoView(todo: $sampleToDo)
                .preferredColorScheme(.light)

            EditToDoView(todo: $sampleToDo)
                .preferredColorScheme(.dark)
        }
    }
}
