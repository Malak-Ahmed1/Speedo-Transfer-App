//
//  LocalNotificationManager.swift
//  Speedo Transfer App
//
//  Created by 1234 on 05/09/2024.
//

import UserNotifications

class LocalNotificationManager {
    
    // Singleton instance for easy access
    static let shared = LocalNotificationManager()
    
    private init() {
    }
    
     func requestNotificationAuthorization() {
        let options: UNAuthorizationOptions = [.alert, .sound, .badge]
        UNUserNotificationCenter.current().requestAuthorization(options: options) { granted, error in
            if let error = error {
                print("Authorization request failed with error: \(error.localizedDescription)")
            } else {
                print("Authorization granted: \(granted)")
            }
        }
    }

    
       func scheduleNotification(title: String, body: String, triggerDate: Date) {
           let content = UNMutableNotificationContent()
           content.title = title
           content.body = body
           content.sound = .default
           
           // Create a trigger for a specific date
           let triggerDateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: triggerDate)
           let trigger = UNCalendarNotificationTrigger(dateMatching: triggerDateComponents, repeats: false)
           
           // Create a unique identifier for the notification
           let identifier = UUID().uuidString
           let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)
           
           // Add the notification request to the notification center
           UNUserNotificationCenter.current().add(request) { error in
               if let error = error {
                   print("Failed to add notification with error: \(error.localizedDescription)")
               } else {
                   print("Notification scheduled successfully.")
               }
           }
         
       }
        
}
