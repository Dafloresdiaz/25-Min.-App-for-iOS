//
//  restNotification.swift
//  Pomodoro
//
//  Created by Daniel Flores on 07/07/20.
//  Copyright © 2020 Daniel Flores. All rights reserved.
//

import Foundation
import UserNotifications

class restNotification {
    
    func restNotification(minutes : Int, seconds : Int, secondsTotal : Int){
        let workMinutes = ((secondsTotal % 3600) / 60)
        let workSeconds = ((secondsTotal % 3600) % 60)
               
        var date = DateComponents()
        date.minute = minutes + workMinutes
        date.second = seconds + workSeconds
        
        
        let content = UNMutableNotificationContent()
        content.title = "¡The break time is over!"
        content.body  = "Go back to work"
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
}
