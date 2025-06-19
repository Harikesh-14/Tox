//
//  ContentView.swift
//  Tox
//
//  Created by Harikesh Ranjan Sinha on 18/06/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedTabIndex: Int = 0

    var body: some View {
        TabView (selection: $selectedTabIndex) {
            Tab("Home", systemImage: "house", value: 0) {
                HomeView()
            }
            
            Tab("Add", systemImage: "plus", value: 1) {
                AddTaskView(selectedTabIndex: $selectedTabIndex)
            }
            
            Tab("Tasks", systemImage: "checkmark", value: 2) {
                TasksView()
            }
        }
        .tint(.appPrimary)
    }

//    private func addItem() {
//        withAnimation {
//            let newItem = Item(timestamp: Date())
//            modelContext.insert(newItem)
//        }
//    }
//
//    private func deleteItems(offsets: IndexSet) {
//        withAnimation {
//            for index in offsets {
//                modelContext.delete(items[index])
//            }
//        }
//    }
}

#Preview {
    ContentView()
        .modelContainer(for: Task.self, inMemory: true)
}
