//
//  workNotification.swift
//  Pomodoro
//
//  Created by Daniel Flores on 07/07/20.
//  Copyright © 2020 Daniel Flores. All rights reserved.
//

import Foundation
import UserNotifications

class workNotification {
    
    func workNotification(){
        let content = UNMutableNotificationContent()
        content.title = "¡Good job!"
        content.body  = "Is time to take a rest"
        content.sound = UNNotificationSound.default
        
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
        
        let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
}
