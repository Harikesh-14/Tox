//
//  NotificationManager.swift
//  Tox
//
//  Created by Harikesh Ranjan Sinha on 19/06/25.
//

import Foundation
import UserNotifications

class NotificationManager {
    static let shared = NotificationManager()
    
    private init() {}
    
    func requestPermission() {
        UNUserNotificationCenter.current().requestAuthorization(
            options: [.alert, .badge, .sound]
        ) { granted, error in
            if let error = error {
                print("Notification Permission Error: \(error.localizedDescription)")
            } else {
                print("Permission granted: \(granted)")
            }
        }
    }
}

extension NotificationManager {
    func scheduleNotification(title: String, deadline: Date, id: String) {
        let content = UNMutableNotificationContent()
        content.title = title
        content.body = "Your task's deadline is approaching"
        content.sound = .default
        
        let triggerTime = deadline.addingTimeInterval(-600)
        
        if triggerTime <= Date() {
            print("Skipped scheduling because time is already passed.")
            return
        }
        
        let triggerDate = Calendar.current.dateComponents(
            [.year, .month, .day, .hour, .minute, .second],
            from: triggerTime
        )
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        
        let request = UNNotificationRequest(identifier: id, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request) { error in
            if let error = error {
                print("Notification scheduling error: \(error.localizedDescription)")
            } else {
                print("Notification scheduled for: \(triggerTime)")
            }
        }
    }
    
    func cancelNotification(for id: String) {
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: [id])
        print("Cancelled notification for task ID: \(id)")
    }
}
