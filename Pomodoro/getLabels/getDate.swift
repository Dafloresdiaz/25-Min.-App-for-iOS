//
//  getDate.swift
//  Pomodoro
//
//  Created by Daniel Flores on 25/06/20.
//  Copyright © 2020 Daniel Flores. All rights reserved.
//

import Foundation

class getDate {
    
    let formatter = DateFormatter()
    let date = Date()
    
    func getDateStringFormat() -> String {
        // This return the date with a type string
        formatter.dateFormat = "dd/MM/yyyy"
        let dateText = formatter.string(from: date)
        return dateText
    }
    
    func getCurrentTime() -> String {
        formatter.dateFormat = "HH:mm:ss"
        let timeText = formatter.string(from: date)
        return timeText
    }
    
}
