//
//  TaskCell.swift
//  Tox
//
//  Created by Harikesh Ranjan Sinha on 18/06/25.
//

import SwiftUI

struct TaskCell: View {
    @Bindable var task: Task
    @Environment(\.modelContext) var modelContext
    @State private var isSheetPresented: Bool = false
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a | dd MMM, yyyy"
        return formatter
    }
    
    var body: some View {
        VStack (spacing: 16) {
            HStack {
                VStack (alignment: .leading, spacing: 8) {
                    Text(task.title)
                        .font(.title3)
                        .fontWeight(.bold)
                        .foregroundColor(.primary)
                    
                    Text (task.desc)
                        .foregroundStyle(.secondary)
                }
                .fontDesign(.rounded)
                
                Spacer()
                
                Button {
                    // Edit task button function
                    isSheetPresented = true
                    
                } label: {
                    Image(systemName: "applepencil.gen1")
                        .foregroundColor(.primary)
                        .font(.title)
                        .fontWeight(.bold)
                }
            }
            
            HStack {
                Text("\(dateFormatter.string(from: task.dateAndTime))")
                    .foregroundStyle(.primary)
                    .font(.footnote)
                
                Spacer()
                
                Toggle ("Mark as complete", isOn: $task.isCompleted)
                    .toggleStyle(CheckBoxToggleStyle())
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundStyle(task.isCompleted ? .green : .primary)
                    .onTapGesture {
                        task.isCompleted.toggle()
                        try? modelContext.save()
                    }
            }
            .sheet(isPresented: $isSheetPresented) {
                EditTaskView(task: task)
            }
        }
        .padding(.vertical, 20)
        .padding(.horizontal, 16)
        .background(Color(.secondarySystemBackground))
        .clipShape(
            RoundedRectangle(cornerRadius: 20)
        )
        .padding(.horizontal)
        .padding(.vertical, 10)
    }
}

#Preview {
    TaskCell(
        task: Task(
            title: "Workout",
            desc: "Complete 30-minute yoga session",
            dateAndTime: Date(),
            isCompleted: false
        )
    )
}


struct CheckBoxToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .frame(width: 24, height: 24)
                .fontWeight(.semibold)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
    }
}
