//
//  LocalNotificationManager.swift
//  RawGameApp
//
//  Created by kamilcal on 24.01.2023.
//

import Foundation
import UserNotifications

protocol LocalNotificationManagerProtocol {
    func scheduleNotification(title: String, body: String) 
}


class localNotificationManager: LocalNotificationManagerProtocol {
    
    static let shared = localNotificationManager()
    
    private let notificationCenter = UNUserNotificationCenter.current()
    
    func requestAuthorization() {
        notificationCenter.requestAuthorization(options: [.alert, .badge, .sound]) { (granted, error) in
            
            guard granted else { return }
            print(granted)
            self.getNotificationSettings()
            
        }
    }
    
    func getNotificationSettings() {
        notificationCenter.getNotificationSettings { (settings) in
            print(settings)
        }
    }
    func scheduleNotification(title: String, body: String) {

                let content = UNMutableNotificationContent()
                content.title = title
                content.body = body


                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
                let identifier = "FavoritesNotification"

                let request = UNNotificationRequest(identifier: identifier, content: content, trigger: trigger)

                notificationCenter.add(request) { (error) in
                    guard let error = error else { return }
                    print(error.localizedDescription)
                }
            }
        }
