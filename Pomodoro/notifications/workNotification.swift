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
    
    func workNotification(hours: Int, minutes : Int, seconds : Int, secondsTotal : Int){
        let workHours   = ((secondsTotal / 3600))
        let workMinutes = ((secondsTotal % 3600) / 60)
        let workSeconds = ((secondsTotal % 3600) % 60)
        
        var date = DateComponents()
        date.hour   = hours + workHours
        date.minute = minutes + workMinutes
        date.second = seconds + workSeconds
        
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
        
        print(date)
        let content = UNMutableNotificationContent()
        content.title = "¡Good job!"
        content.body  = "Is time to take a rest"
        content.sound = UNNotificationSound.default
        
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: date, repeats: false)
        
        let request = UNNotificationRequest(identifier: "notification", content: content, trigger: trigger)
        
        UNUserNotificationCenter.current().add(request)
    }
    
}
