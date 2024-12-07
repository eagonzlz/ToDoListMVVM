//
//  ToDo.swift
//  ToDoListMVVM
//
//  Created by Emanuel Gonzalez on 12/7/24.
//


// Models/ToDo.swift
import Foundation

struct ToDo: Identifiable, Codable {
    let id: UUID
    var title: String
    var isCompleted: Bool

    init(id: UUID = UUID(), title: String, isCompleted: Bool = false) {
        self.id = id
        self.title = title
        self.isCompleted = isCompleted
    }
}