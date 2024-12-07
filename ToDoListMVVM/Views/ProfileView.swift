//
//  ProfileView.swift
//  ToDoListMVVM
//
//  Created by Emanuel Gonzalez on 12/7/24.
//

import SwiftUI

struct ProfileView: View {
    @Environment(\.dismiss) private var dismiss
    @ObservedObject var viewModel: ProfileViewModel
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false

    @State private var tempName: String
    @State private var tempEmail: String

    init(viewModel: ProfileViewModel) {
        self.viewModel = viewModel
        _tempName = State(initialValue: viewModel.name)
        _tempEmail = State(initialValue: viewModel.email)
    }

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("User Information")) {
                    TextField("Name", text: $tempName)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                    TextField("Email", text: $tempEmail)
                        .textFieldStyle(RoundedBorderTextFieldStyle())
                        .keyboardType(.emailAddress)
                        .autocapitalization(.none)
                }

                Section(header: Text("Appearance")) {
                    Toggle(isOn: $isDarkMode) {
                        Text("Dark Mode")
                    }
                    .tint(.yellow)
                }
            }
            .navigationTitle("Profile")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .foregroundColor(isDarkMode ? .yellow : .accentColor)
                }
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Save") {
                        viewModel.name = tempName
                        viewModel.email = tempEmail
                        viewModel.saveProfile()
                        dismiss()
                    }
                    .foregroundColor(isDarkMode ? .yellow : .accentColor)
                }
            }
            .preferredColorScheme(isDarkMode ? .dark : .light)
        }
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            ProfileView(viewModel: ProfileViewModel())
                .preferredColorScheme(.light)

            ProfileView(viewModel: ProfileViewModel())
                .preferredColorScheme(.dark)
        }
    }
}

