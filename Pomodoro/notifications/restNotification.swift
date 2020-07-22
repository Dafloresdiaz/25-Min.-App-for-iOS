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
    
    func restNotification(hours: Int, minutes : Int, seconds : Int, secondsTotal : Int){
        let restHours   = (secondsTotal / 3600)
        let restMinutes = ((secondsTotal % 3600) / 60)
        let restSeconds = ((secondsTotal % 3600) % 60)
               
        var date = DateComponents()
        date.hour   = hours + restHours
        date.minute = minutes + restMinutes
        date.second = seconds + restSeconds
        
        if (date.second! > 60) {
            date.second! = date.second! - 60
            date.minute! += 1
        }
        
        if (date.minute! > 60) {
            date.minute! = date.minute! - 60
            date.hour! += 1
        }
        
        if (date.hour! > 23) {
            date.hour! = 0
        }
        
        let content = UNMutableNotificationContent()
        content.title = "¡The break time is over!"
        content.body  = "Go back to work"
        content.sound = UNNotificationSound.default
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
}
