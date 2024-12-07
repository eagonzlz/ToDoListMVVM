//
//  ProfileViewModel.swift
//  ToDoListMVVM
//
//  Created by Emanuel Gonzalez on 12/7/24.
//


import Foundation

class ProfileViewModel: ObservableObject {
    @Published var name: String = ""
    @Published var email: String = ""

    // Simulating persistence with UserDefaults (replace with Core Data or other storage as needed)
    private let nameKey = "profile_name"
    private let emailKey = "profile_email"

    init() {
        loadProfile()
    }

    func saveProfile() {
        UserDefaults.standard.set(name, forKey: nameKey)
        UserDefaults.standard.set(email, forKey: emailKey)
    }

    func loadProfile() {
        name = UserDefaults.standard.string(forKey: nameKey) ?? ""
        email = UserDefaults.standard.string(forKey: emailKey) ?? ""
    }
}
