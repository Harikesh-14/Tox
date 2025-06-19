//
//  TasksView.swift
//  Tox
//
//  Created by Harikesh Ranjan Sinha on 18/06/25.
//

import SwiftUI
import SwiftData

struct TasksView: View {
    @State private var filterTask: TaskFilter = .all
    @Query var tasks: [Task]
    
    private var filteredTasks: [Task] {
        switch filterTask {
        case .all:
            return tasks
        case .completed:
            return tasks.filter { $0.isCompleted }
        case .pending:
            return tasks.filter { !$0.isCompleted }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.15)
                    .ignoresSafeArea(.all)
                
                ScrollView {
                    VStack {
                        TasksFilter(filterTask: $filterTask)
                        
                        ForEach (filteredTasks, id: \.self) { task in
                            TaskCell(task: task)
                        }
                    }
                }
            }
            .navigationTitle("Tasks")
        }
    }
}

#Preview {
    TasksView()
}

struct TasksFilter: View {
    @Binding var filterTask: TaskFilter
    @Namespace var animation
    
    private var filterBarWidth: CGFloat {
        let count = TaskFilter.allCases.count
        return UIScreen.main.bounds.width / CGFloat(count) - 16
    }
    
    var body: some View {
        HStack {
            ForEach (TaskFilter.allCases, id: \.self) { filter in
                VStack {
                    Text(filter.title)
                        .font(.title3)
                        .fontWeight(.semibold)
                        .foregroundColor(filterTask == filter ? .appPrimary : .primary)
                    
                    if filterTask == filter {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.appPrimary)
                            .frame(width: filterBarWidth, height: 2)
                            .matchedGeometryEffect(id: "item", in: animation)
                    } else {
                        RoundedRectangle(cornerRadius: 10)
                            .foregroundStyle(Color.gray.opacity(0.01))
                        .frame(width: filterBarWidth, height: 2)                    }
                }
                .onTapGesture {
                    withAnimation (.spring()) {
                        filterTask = filter
                    }
                }
            }
        }
        .padding(.top)
    }
}
