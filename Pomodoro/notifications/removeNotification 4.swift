//
//  removeNotification.swift
//  Pomodoro
//
//  Created by Daniel Flores on 08/07/20.
//  Copyright © 2020 Daniel Flores. All rights reserved.
//

import Foundation
import UserNotifications

class removeNotifications {
    
    func removeCurrentNotification(){
        UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["notification"])
    }
    
}

