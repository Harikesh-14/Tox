//
//  TaskSheet.swift
//  Tox
//
//  Created by Harikesh Ranjan Sinha on 22/06/25.
//

import SwiftUI

struct TaskSheet: View {
    var task: Task
    @Environment(\.dismiss) var dismiss
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a | dd MMM, yyyy"
        return formatter
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 0) {
                    // Header Section
                    VStack(alignment: .leading, spacing: 16) {
                        Text(task.title)
                            .font(.largeTitle)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.leading)
                        
                        // Status Pills
                        HStack(spacing: 12) {
                            StatusPill(
                                text: task.isCompleted ? "Completed" : "Pending",
                                color: task.isCompleted ? .green : .orange,
                                icon: task.isCompleted ? "checkmark.circle.fill" : "clock.fill"
                            )
                            
                            if task.isImportant {
                                StatusPill(
                                    text: "Important",
                                    color: .red,
                                    icon: "exclamationmark.circle.fill"
                                )
                            }
                            
                            Spacer()
                        }
                    }
                    .padding(.horizontal, 20)
                    .padding(.top, 20)
                    .padding(.bottom, 24)
                    
                    // Content Cards
                    VStack(spacing: 16) {
                        // Description Card
                        InfoCard(
                            title: "Description",
                            icon: "text.alignleft",
                            iconColor: .blue
                        ) {
                            Text(task.desc)
                                .font(.body)
                                .foregroundStyle(.primary)
                                .lineLimit(nil)
                        }
                        
                        // Deadline Card
                        InfoCard(
                            title: "Deadline",
                            icon: "calendar",
                            iconColor: .orange
                        ) {
                            HStack {
                                Text(dateFormatter.string(from: task.dateAndTime))
                                    .font(.body)
                                    .fontWeight(.medium)
                                    .foregroundStyle(.primary)
                                
                                Spacer()
                                
                                // Time remaining indicator
                                TimeRemainingView(deadline: task.dateAndTime)
                            }
                        }
                        
                        // Status Card
                        InfoCard(
                            title: "Status",
                            icon: "info.circle",
                            iconColor: .purple
                        ) {
                            VStack(spacing: 12) {
                                StatusRow(
                                    label: "Completion",
                                    isActive: task.isCompleted,
                                    activeText: "Completed",
                                    inactiveText: "Pending"
                                )
                                
                                StatusRow(
                                    label: "Priority",
                                    isActive: task.isImportant,
                                    activeText: "High Priority",
                                    inactiveText: "Normal Priority"
                                )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                    
                    Spacer(minLength: 40)
                }
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Task Details")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Done") {
                        dismiss()
                    }
                    .font(.body)
                    .fontWeight(.medium)
                }
            }
        }
    }
}

// MARK: - Supporting Views

struct StatusPill: View {
    let text: String
    let color: Color
    let icon: String
    
    var body: some View {
        HStack(spacing: 6) {
            Image(systemName: icon)
                .font(.caption)
            Text(text)
                .font(.caption)
                .fontWeight(.medium)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 6)
        .background(color.opacity(0.15))
        .foregroundStyle(color)
        .clipShape(Capsule())
    }
}

struct InfoCard<Content: View>: View {
    let title: String
    let icon: String
    let iconColor: Color
    @ViewBuilder let content: Content
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack(spacing: 8) {
                Image(systemName: icon)
                    .font(.headline)
                    .foregroundStyle(iconColor)
                
                Text(title)
                    .font(.headline)
                    .fontWeight(.semibold)
                    .foregroundStyle(.primary)
                
                Spacer()
            }
            
            content
        }
        .padding(16)
        .background(Color(.secondarySystemGroupedBackground))
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
}

struct StatusRow: View {
    let label: String
    let isActive: Bool
    let activeText: String
    let inactiveText: String
    
    var body: some View {
        HStack {
            Text(label)
                .font(.body)
                .foregroundStyle(.secondary)
            
            Spacer()
            
            HStack(spacing: 6) {
                Image(systemName: isActive ? "checkmark.circle.fill" : "circle")
                    .font(.body)
                    .foregroundStyle(isActive ? .green : .secondary)
                
                Text(isActive ? activeText : inactiveText)
                    .font(.body)
                    .fontWeight(.medium)
                    .foregroundStyle(isActive ? .green : .secondary)
            }
        }
    }
}

struct TimeRemainingView: View {
    let deadline: Date
    
    private var timeRemaining: String {
        let now = Date()
        let timeInterval = deadline.timeIntervalSince(now)
        
        if timeInterval < 0 {
            return "Overdue"
        } else if timeInterval < 3600 {
            let minutes = Int(timeInterval / 60)
            return "\(minutes)m left"
        } else if timeInterval < 86400 {
            let hours = Int(timeInterval / 3600)
            return "\(hours)h left"
        } else {
            let days = Int(timeInterval / 86400)
            return "\(days)d left"
        }
    }
    
    private var timeColor: Color {
        let now = Date()
        let timeInterval = deadline.timeIntervalSince(now)
        
        if timeInterval < 0 {
            return .red
        } else if timeInterval < 86400 {
            return .orange
        } else {
            return .secondary
        }
    }
    
    var body: some View {
        Text(timeRemaining)
            .font(.caption)
            .fontWeight(.medium)
            .foregroundStyle(timeColor)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(timeColor.opacity(0.1))
            .clipShape(Capsule())
    }
}

#Preview {
    TaskSheet(
        task: Task(
            title: "Workout",
            desc: "The golden sun dipped behind the hills, casting long shadows across the quiet meadow. A soft breeze carried the scent of blooming jasmine, while birds chirped their final songs of the day. Emma sat beneath the old oak tree, her fingers brushing the petals of a daisy, lost in thought. The world felt still, peaceful — as if time itself had paused just for her.",
            dateAndTime: .distantFuture,
            isCompleted: true,
            isImportant: false,
        )
    )
}
