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
    @Environment(\.dismiss) var dismiss
    @State private var isSheetPresented: Bool = false
    @State private var isLongPressSheetPresented: Bool = false
    
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
                        .lineLimit(2)
                }
                .fontDesign(.rounded)
                
                Spacer()
                
                HStack (spacing: 10) {
                    // Edit button
                    Button {
                        // Edit task button function
                        isSheetPresented = true
                        
                    } label: {
                        Image(systemName: "applepencil.gen1")
                            .font(.title2)
                    }
                    
                    // Delete button
                    Button {
                        NotificationManager.shared.cancelNotification(for: task.id)
                        modelContext.delete(task)
                        try? modelContext.save()
                    } label: {
                        Image(systemName: "trash")
                            .font(.headline)
                    }
                }
                .foregroundColor(.primary)
                .fontWeight(.bold)
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
                    .onChange(of: task.isCompleted) {
                        if task.isCompleted {
                            NotificationManager.shared.cancelNotification(for: task.id)
                        } else {
                            NotificationManager.shared.scheduleNotification(title: task.title, deadline: task.dateAndTime, id: task.id)
                        }
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
        .onLongPressGesture {
            isLongPressSheetPresented = true
        }
        .sheet(isPresented: $isLongPressSheetPresented) {
            TaskSheet(task: task)
        }
    }
}

#Preview {
    TaskCell(
        task: Task(
            title: "Workout",
            desc: "The golden sun dipped behind the hills, casting long shadows across the quiet meadow. A soft breeze carried the scent of blooming jasmine, while birds chirped their final songs of the day. Emma sat beneath the old oak tree, her fingers brushing the petals of a daisy, lost in thought. The world felt still, peaceful — as if time itself had paused just for her.",
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
