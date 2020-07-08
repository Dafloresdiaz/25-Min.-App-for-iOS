//
//  generalConfig.swift
//  Pomodoro
//
//  Created by Daniel Flores on 02/07/20.
//  Copyright © 2020 Daniel Flores. All rights reserved.
//

import Foundation
import UserNotifications

let notificationCenter   = UNUserNotificationCenter.current()
let sendWorkNotification = workNotification()
let sendRestNotification = restNotification()

class configNotifications {
    
    
    init(){
        notificationCenter.requestAuthorization(options: [.alert, .sound, .badge]){ (granted, error) in
                   if granted {
                       print("yey")
                   }else{
                       print("nop")
                   }
        }
    }
    
    func sendNotification(isBreak : Bool){
        if (isBreak){
            sendRestNotification.restNotification()
        }else{
            sendWorkNotification.workNotification()
        }
    }
}



