//
//  getDate.swift
//  Pomodoro
//
//  Created by Daniel Flores on 25/06/20.
//  Copyright © 2020 Daniel Flores. All rights reserved.
//

import Foundation

class getDateAndTimeInfo {
    
    let formatter = DateFormatter()
    
    func getDateStringFormat() -> String {
        let date = Date()
        // This return the date with a type string
        formatter.dateFormat = "dd/MM/yyyy"
        let dateText = formatter.string(from: date)
        return dateText
    }
    
    func getTimeStringFormat() -> String {
        let date = Date()
        formatter.timeStyle = .medium
        formatter.dateStyle = .none
        return (formatter.string(from: date))
    }
    
    func getCurrentHour () -> Int {
        let date = Date()
        formatter.dateFormat = "HH"
        let hours = formatter.string(from: date)
        return Int(hours)!
    }
    
    func getCurrentMinutes() -> Int {
        let date = Date()
        formatter.dateFormat = "mm"
        let minutes = formatter.string(from: date)
        return Int(minutes)!
    }
    
    func geCurrentSeconds() -> Int {
        let date = Date()
        formatter.dateFormat = "ss"   
        let seconds = formatter.string(from: date)
        return Int(seconds)!
    }
    
    func secondsBetweenDates(startDate : Date, endDate: Date) -> Int{
        return Int(startDate.timeIntervalSince(endDate))
        
    }
    
}
