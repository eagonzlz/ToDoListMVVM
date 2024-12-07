//
//  ToDoViewModel.swift
//  ToDoListMVVM
//
//  Created by Emanuel Gonzalez on 12/6/24.
//

import Foundation

class ToDoViewModel: ObservableObject {
    @Published var todos: [ToDo] = [] {
        didSet {
            saveToDos()
        }
    }
 
    private let todosKey = "ToDoListKey"
 
    init() {
        loadToDos()
    }

    func addToDo(title: String) {
                let trimmedTitle = title.trimmingCharacters(in: .whitespacesAndNewlines)
                guard !trimmedTitle.isEmpty else { return }
                let newToDo = ToDo(title: trimmedTitle)
                todos.append(newToDo)
    }
    
    func loadSampleData() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) { [weak self] in
            self?.todos = [
                ToDo(title: "Buy groceries"),
                ToDo(title: "Walk the dog"),
                ToDo(title: "Read a book")
            ]
        }
    }

    func toggleCompletion(for todo: ToDo) {
        if let index = todos.firstIndex(where: { $0.id == todo.id }) {
            todos[index].isCompleted.toggle()
        }
    }

    func removeToDo(at offsets: IndexSet) {
        todos.remove(atOffsets: offsets)
    }
    
    private func saveToDos() {
        if let encodedData = try? JSONEncoder().encode(todos) {
            UserDefaults.standard.set(encodedData, forKey: todosKey)
        }
    }
     
    private func loadToDos() {
        if let data = UserDefaults.standard.data(forKey: todosKey),
            let decodedToDos = try? JSONDecoder().decode([ToDo].self, from: data) {
            todos = decodedToDos
        } else {
            loadSampleData()
        }
    }
}
