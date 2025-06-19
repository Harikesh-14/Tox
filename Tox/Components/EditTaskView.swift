//
//  EditTaskView.swift
//  Tox
//
//  Created by Harikesh Ranjan Sinha on 19/06/25.
//

import SwiftUI

struct EditTaskView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @Bindable var task: Task
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.gray.opacity(0.15)
                    .ignoresSafeArea(.all)
                
                ScrollView {
                    VStack (spacing: 30) {
                        VStack (alignment: .leading) {
                            Text ("Task Title")
                                .foregroundStyle(.primary.opacity(0.7))
                                .fontWeight(.medium)
                                .fontDesign(.rounded)
                                .padding(.horizontal, 10)
                            
                            TextField ("Eg: Buy milk", text: $task.title)
                                .padding()
                                .frame(height: 50)
                                .background(.tertiary.opacity(0.2))
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 10)
                                )
                        }
                        
                        VStack (alignment: .leading) {
                            Text ("Task Description")
                                .foregroundStyle(.primary.opacity(0.7))
                                .fontWeight(.medium)
                                .fontDesign(.rounded)
                                .padding(.horizontal, 10)
                            
                            TextField("Buy milk before the sun sets", text: $task.desc, axis: .vertical)
                                .padding()
                                .frame(height: 60)
                                .background(.tertiary.opacity(0.2))
                                .clipShape(
                                    RoundedRectangle(cornerRadius: 10)
                                )
                        }
                        
                        VStack(alignment: .leading) {
                            Text("Set Deadline")
                                .foregroundStyle(.primary.opacity(0.7))
                                .fontWeight(.medium)
                                .fontDesign(.rounded)
                                .padding(.horizontal, 10)
                            
                            HStack {
                                DatePicker(
                                    "Deadline",
                                    selection: $task.dateAndTime,
                                    displayedComponents: [.date, .hourAndMinute]
                                )
                                .labelsHidden()
                                .tint(.appPrimary)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        
                        Divider()
                        
                        VStack (alignment: .leading) {
                            Toggle ("Mark as important", isOn: $task.isImportant)
                                .toggleStyle(PriorityToggleStyle())
                                .fontWeight(.semibold)
                        }
                        
                        Divider()
                        
                        Spacer()
                        
                        Button {
                            try? modelContext.save()
                            dismiss()
                        } label: {
                            Text("Edit Task")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .foregroundColor(.white)
                        .background(task.title.isEmpty ? Color.appPrimary.opacity(0.7) : Color.appPrimary)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .disabled(task.title.isEmpty)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 40)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Text("Edit Task")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.primary)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Text("Cancel")
                    }
                    .foregroundStyle(.primary)
                }
            }
        }
    }
}

#Preview {
    EditTaskView(
        task: Task(title: "Exercise", desc: "Go to Gymm", dateAndTime: .now, isCompleted: true, isImportant: true)
    )
}
