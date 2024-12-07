//
//  ToDoListView.swift
//  ToDoListMVVM
//
//  Created by Emanuel Gonzalez on 12/6/24.
//

import SwiftUI

struct ToDoListView: View {
    @StateObject private var viewModel = ToDoViewModel()
    @State private var newToDoTitle: String = ""
    @State private var selectedToDo: ToDo? = nil
    @State private var isProfileViewPresented: Bool = false
    @StateObject private var profileViewModel = ProfileViewModel()
    @State private var taskToDelete: ToDo? = nil
    @State private var showDeleteConfirmation = false

    @Environment(\.colorScheme) private var colorScheme // Detect the current mode

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    TextField("Enter new To-Do", text: $newToDoTitle)
                        .padding(10)
                        .background(
                            RoundedRectangle(cornerRadius: 8)
                                .fill(colorScheme == .dark ? Color.white.opacity(0.2) : Color(UIColor.systemBackground))
                        )
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.gray, lineWidth: 1)
                        )
                        .padding(.leading, 16)
                    
                    Button(action: {
                        guard !newToDoTitle.isEmpty else { return }
                        viewModel.addToDo(title: newToDoTitle)
                        newToDoTitle = ""
                    }) {
                        Image(systemName: "plus")
                            .padding()
                            .background(colorScheme == .dark ? Color.yellow : Color.accentColor)
                            .foregroundColor(colorScheme == .dark ? .black : .white)
                            .clipShape(Circle())
                    }
                    .padding(.trailing, 16)
                }
                .padding(.vertical, 8)

                List {
                    ForEach(viewModel.todos) { todo in
                        HStack {
                            Text(todo.title)
                                .strikethrough(todo.isCompleted, color: .primary)
                                .foregroundColor(todo.isCompleted ? .gray : (colorScheme == .dark ? .white : .primary))
                            Spacer()
                            Button(action: {
                                viewModel.toggleCompletion(for: todo)
                            }) {
                                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(colorScheme == .dark ? .yellow : (todo.isCompleted ? .green : .gray))
                            }
                        }
                        .padding(.vertical, 4)
                        .onTapGesture {
                            selectedToDo = todo
                        }
                    }
                    .onDelete(perform: handleDelete)
                }
                .sheet(item: $selectedToDo) { todo in
                    EditToDoView(todo: binding(for: todo))
                }
                .alert(isPresented: $showDeleteConfirmation) {
                    Alert(
                        title: Text("Delete Task"),
                        message: Text("Are you sure you want to delete \"\(taskToDelete?.title ?? "")\"?"),
                        primaryButton: .destructive(Text("Delete")) {
                            if let task = taskToDelete,
                               let index = viewModel.todos.firstIndex(where: { $0.id == task.id }) {
                                viewModel.todos.remove(at: index)
                                taskToDelete = nil
                            }
                        },
                        secondaryButton: .cancel {
                            taskToDelete = nil
                        }
                    )
                }
            }
            .navigationTitle("To-Do List")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    EditButton()
                        .foregroundColor(colorScheme == .dark ? .yellow : .accentColor)
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    Button(action: {
                        isProfileViewPresented.toggle()
                    }) {
                        Image(systemName: "person.circle.fill")
                            .font(.title)
                            .foregroundColor(colorScheme == .dark ? .yellow : .accentColor)
                    }
                    .sheet(isPresented: $isProfileViewPresented) {
                        ProfileView(viewModel: profileViewModel)
                    }
                }
            }
        }
    }

    private func handleDelete(at offsets: IndexSet) {
        if let index = offsets.first {
            taskToDelete = viewModel.todos[index]
            showDeleteConfirmation = true
        }
    }

    private func binding(for todo: ToDo) -> Binding<ToDo> {
        guard let index = viewModel.todos.firstIndex(where: { $0.id == todo.id }) else {
            fatalError("To-Do not found")
        }
        return $viewModel.todos[index]
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ToDoListView()
                .preferredColorScheme(.light)

            ToDoListView()
                .preferredColorScheme(.dark)
        }
    }
}






//import SwiftUI
//
//struct ToDoListView: View {
//    @StateObject private var viewModel = ToDoViewModel()
//    @State private var newToDoTitle: String = ""
//    @State private var selectedToDo: ToDo? = nil
//    @State private var isProfileViewPresented: Bool = false
//    @StateObject private var profileViewModel = ProfileViewModel()
//    @State private var taskToDelete: ToDo? = nil
//    @State private var showDeleteConfirmation = false
//
//    var body: some View {
//        NavigationView {
//            VStack {
//                HStack {
//                    TextField("Enter new To-Do", text: $newToDoTitle)
//                        .textFieldStyle(RoundedBorderTextFieldStyle())
//                        .padding(.leading, 16)
//                    Button(action: {
//                        guard !newToDoTitle.isEmpty else { return }
//                        viewModel.addToDo(title: newToDoTitle)
//                        newToDoTitle = ""
//                    }) {
//                        Image(systemName: "plus")
//                            .padding()
//                            .background(Color.accentColor)
//                            .foregroundColor(.white)
//                            .clipShape(Circle())
//                    }
//                    .padding(.trailing, 16)
//                }
//                .padding(.vertical, 8)
//
//                List {
//                    ForEach(viewModel.todos) { todo in
//                        HStack {
//                            Text(todo.title)
//                                .strikethrough(todo.isCompleted, color: .primary)
//                                .foregroundColor(todo.isCompleted ? .gray : .primary)
//                            Spacer()
//                            Button(action: {
//                                viewModel.toggleCompletion(for: todo)
//                            }) {
//                                Image(systemName: todo.isCompleted ? "checkmark.circle.fill" : "circle")
//                                    .foregroundColor(todo.isCompleted ? .green : .gray)
//                            }
//                        }
//                        .padding(.vertical, 4)
//                        .onTapGesture {
//                            selectedToDo = todo
//                        }
//                    }
//                    .onDelete(perform: handleDelete)
//                }
//                .sheet(item: $selectedToDo) { todo in
//                    EditToDoView(todo: binding(for: todo))
//                }
//                .alert(isPresented: $showDeleteConfirmation) {
//                    Alert(
//                        title: Text("Delete Task"),
//                        message: Text("Are you sure you want to delete \"\(taskToDelete?.title ?? "")\"?"),
//                        primaryButton: .destructive(Text("Delete")) {
//                            if let task = taskToDelete,
//                               let index = viewModel.todos.firstIndex(where: { $0.id == task.id }) {
//                                viewModel.todos.remove(at: index)
//                                taskToDelete = nil
//                            }
//                        },
//                        secondaryButton: .cancel {
//                            taskToDelete = nil
//                        }
//                    )
//                }
//            }
//            .navigationTitle("To-Do List")
//            .toolbar {
//                ToolbarItem(placement: .navigationBarTrailing) {
//                    EditButton()
//                }
//                ToolbarItem(placement: .navigationBarLeading) {
//                    Button(action: {
//                        isProfileViewPresented.toggle()
//                    }) {
//                        Image(systemName: "person.circle.fill")
//                            .font(.title)
//                            .foregroundColor(.accentColor)
//                    }
//                    .sheet(isPresented: $isProfileViewPresented) {
//                        ProfileView(viewModel: profileViewModel)
//                    }
//                }
//            }
//        }
//    }
//
//    private func handleDelete(at offsets: IndexSet) {
//        if let index = offsets.first {
//            taskToDelete = viewModel.todos[index]
//            showDeleteConfirmation = true
//        }
//    }
//
//    private func binding(for todo: ToDo) -> Binding<ToDo> {
//        guard let index = viewModel.todos.firstIndex(where: { $0.id == todo.id }) else {
//            fatalError("To-Do not found")
//        }
//        return $viewModel.todos[index]
//    }
//}
//
//struct ToDoListView_Previews: PreviewProvider {
//    static var previews: some View {
//        Group {
//            ToDoListView()
//                .preferredColorScheme(.light)
//
//            ToDoListView()
//                .preferredColorScheme(.dark)
//        }
//    }
//}
