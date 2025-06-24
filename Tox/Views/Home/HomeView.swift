//
//  HomeView.swift
//  Tox
//
//  Created by Harikesh Ranjan Sinha on 18/06/25.
//

import SwiftUI
import SwiftData

struct HomeView: View {
    @Environment(\.modelContext) var modelContext
    @Query var tasks: [Task]
    
    var body: some View {
        NavigationStack {
            if tasks.isEmpty {
                ZStack {
                    Color.gray.opacity(0.15).ignoresSafeArea()
                    NoTaskView()
                }
            } else {
                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 16) {
                        Text("Hello, Harikesh 👋🏻")
                            .font(.system(size: 32, weight: .bold, design: .rounded))
                            .padding(.horizontal, 24)
                        
                        ForEach(tasks) { task in
                            TaskCell(task: task)
                        }
                    }
                    .padding(.top, 32)
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
