//
//  generalConfig.swift
//  Pomodoro
//
//  Created by Daniel Flores on 02/07/20.
//  Copyright © 2020 Daniel Flores. All rights reserved.
//

import Foundation
import UserNotifications

let notificationCenter = UNUserNotificationCenter.current()

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

}



