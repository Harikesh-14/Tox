//
//  AddTaskView.swift
//  Tox
//
//  Created by Harikesh Ranjan Sinha on 19/06/25.
//

import SwiftUI

struct AddTaskView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var taskTitle: String = ""
    @State private var taskDesc: String = ""
    @State private var taskDate: Date = .now
    @State private var isCompleted: Bool = false
    @State private var isImportant: Bool = false
    @Binding var selectedTabIndex: Int
    
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
                            
                            TextField ("Eg: Buy milk", text: $taskTitle)
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
                            
                            TextField("Buy milk before the sun sets", text: $taskDesc, axis: .vertical)
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
                                    selection: $taskDate,
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
                            Toggle ("Mark as important", isOn: $isImportant)
                                .toggleStyle(PriorityToggleStyle())
                                .fontWeight(.semibold)
                        }
                        
                        Divider()
                        
                        Spacer()
                        
                        Button {
                            let newTask = Task(
                                title: taskTitle,
                                desc: taskDesc,
                                dateAndTime: taskDate,
                                isCompleted: isCompleted,
                                isImportant: isImportant
                            )
                            
                            modelContext.insert(newTask)
                            taskTitle = ""
                            taskDesc = ""
                            taskDate = Date()
                            isCompleted = false
                            isImportant = false
                            selectedTabIndex = 0
                        } label: {
                            Text ("Add Task")
                                .fontWeight(.semibold)
                        }
                        .frame(maxWidth: .infinity, minHeight: 50)
                        .foregroundColor(.white)
                        .background((taskTitle.isEmpty) ? Color.appPrimary.opacity(0.7) : Color.appPrimary)
                        .clipShape(
                            RoundedRectangle(cornerRadius: 10)
                        )
                        .disabled(taskTitle.isEmpty ? true : false)
                        
                    }
                    .padding(.horizontal, 20)
                    .padding(.vertical, 40)
                }
            }
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        selectedTabIndex = 0
                    } label: {
                        HStack {
                            Image (systemName: "arrow.left")
                            
                            Text("Add Task")
                        }
                        .font(.title2)
                        .fontWeight(.semibold)
                    }
                    .foregroundStyle(.primary)
                }
            }
        }
    }
}

#Preview {
    AddTaskView(
        selectedTabIndex: .constant(0)
    )
}

struct PriorityToggleStyle: ToggleStyle {
    func makeBody(configuration: Configuration) -> some View {
        HStack {
            configuration.label
            Spacer()
            Image(systemName: configuration.isOn ? "checkmark.square.fill" : "square")
                .resizable()
                .foregroundStyle(configuration.isOn ? Color.appPrimary : Color.primary)
                .frame(width: 24, height: 24)
                .fontWeight(.semibold)
                .onTapGesture {
                    configuration.isOn.toggle()
                }
        }
        .padding(.horizontal, 8)
    }
}
