//
//  NotificationManager.swift
//  SeaHerd
//
//  Created by Tommaso on 26/10/2019.
//  Copyright © 2019 spaceapp. All rights reserved.
//

import Foundation
import UserNotifications

struct Notification {
    var id:String
    var title:String
}

class NotificationManager {
    var notifications = [Notification]()
    
    
    func listScheduledNotifications() {
        UNUserNotificationCenter.current().getPendingNotificationRequests { notifications in

            for notification in notifications {
                print(notification)
            }
        }
    }
    
    func schedule() {
        UNUserNotificationCenter.current().getNotificationSettings { settings in

            switch settings.authorizationStatus {
            case .notDetermined:
                self.requestAuthorization()
            case .authorized, .provisional:
                self.scheduleNotifications()
            default:
                print("did def")
                break // Do nothing
            }
        }
    }
    
    private func requestAuthorization() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound]) { granted, error in

            if granted == true && error == nil {
                self.scheduleNotifications()
            }
        }
    }

    
    private func scheduleNotifications() {
        for notification in notifications {
            let content      = UNMutableNotificationContent()
            content.title    = notification.title
            content.sound    = .default

           let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 10, repeats: false)
            
            let request = UNNotificationRequest(identifier: notification.id, content: content, trigger: trigger)

            UNUserNotificationCenter.current().add(request) { error in
                guard error == nil else { return }
            }
        }
    }
    
}
