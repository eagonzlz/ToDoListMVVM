//
//  ContentView.swift
//  ToDoListMVVM
//
//  Created by Emanuel Gonzalez on 12/6/24.
//

// ContentView.swift
import SwiftUI

struct ContentView: View {
    @AppStorage("isDarkMode") private var isDarkMode: Bool = false
    var body: some View {
        ToDoListView()
            .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
