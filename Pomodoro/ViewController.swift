//
//  ViewController.swift
//  Pomodoro
//
//  Created by Daniel Flores on 23/06/20.
//  Copyright © 2020 Daniel Flores. All rights reserved.
//

import UIKit
import MBCircularProgressBar

class ViewController: UIViewController {
    
    @IBOutlet weak var getTimerUpdate: UILabel!
    @IBOutlet weak var buttonStartOrPause: UIButton!
    @IBOutlet weak var totalRoundsCount: UILabel!
    @IBOutlet weak var circularProgBar: MBCircularProgressBarView!
    
    let pauseImage = UIImage(systemName: "pause.circle")
    let playImage = UIImage(systemName: "play.circle")
    let activeNotification = NotificationCenter.default
    let backgroundNotification = NotificationCenter.default

    var startDate = Date()
    var endDate = Date()
    var countActive = 0
    var againActive = false
    var isPaused = true
    var roundCount = 0
    
    //25 min are 1500 seconds
    //5 min are 300 seconds
    //20 min are 1200 seconds
    var secondsTotal = 1500
    var countSeconds : CGFloat = 0
    var isBreak = false
    
    let getInfoDateTime = getDateAndTimeInfo()
    let createNotifications = configNotifications()
    let removeNotification = removeNotifications()
    
    var timer : Timer = Timer()
    
    //Function for the view Load
    override func viewDidLoad() {
        super.viewDidLoad()
        circularProgBar.value = 0
        circularProgBar.maxValue = CGFloat(secondsTotal)
        activeNotification.addObserver(self, selector: #selector(appAgainActive), name: UIApplication.didBecomeActiveNotification, object: nil)
        backgroundNotification.addObserver(self, selector: #selector(appInBackGround), name: UIApplication.didEnterBackgroundNotification, object: nil)
    }

    //FUnction for the start and pause the timer
    @IBAction func startOrPauseTime(_ sender: Any) {
        if isPaused {
            startDate = Date()
            timer = Timer.scheduledTimer(timeInterval: 1.0,
                                         target: self,
                                         selector: #selector(getTimerRunning),
                                         userInfo: nil, repeats: true)
            
            buttonStartOrPause.setImage(pauseImage, for: .normal)
            
            //Make a function of this behavior
            let currentMinutes = getInfoDateTime.getCurrentMinutes()
            let currentSeconds = getInfoDateTime.geCurrentSeconds()
            createNotifications.sendNotification(isBreak: isBreak, minutes: currentMinutes, seconds: currentSeconds, secondsTotal: secondsTotal)
            
            isPaused = false
            
        }else{
            timer.invalidate()
            removeNotification.removeCurrentNotification()
            buttonStartOrPause.setImage(playImage, for: .normal)
            isPaused = true
        }
    }
    
    //Function to do the process of countdown the timer for each second
    //make the progress of the bar, to make it more clear the time is running
    //If the seocnd reach 0 is necessary to start form the beginign the
    //progress bar and change the labels with the correct string
    @objc func getTimerRunning(){
        
        if secondsTotal == 300 || secondsTotal == 1200 {
            isBreak = true
        }
        
        if(!isPaused && againActive){
            let secondBackground = getInfoDateTime.secondsBetweenDates(startDate: startDate, endDate: endDate)
            secondsTotal = secondsTotal + secondBackground
            countSeconds = countSeconds - CGFloat(secondBackground)
            againActive = false
        }
        
        secondsTotal -= 1
        countSeconds += 1
        circularProgBar.value = countSeconds
        
        
        let minutes = Int(secondsTotal / 60 % 60)
        let seconds = Int(secondsTotal % 60)
        
        if (minutes < 10){
            getTimerUpdate.text = "0\(minutes):\(seconds)"
        }else if (minutes < 10 && seconds < 10) {
            getTimerUpdate.text = "0\(minutes):0\(seconds)"
        }else if (seconds < 10) {
            getTimerUpdate.text = "\(minutes):0\(seconds)"
        }else{
            getTimerUpdate.text = "\(minutes):\(seconds)"
        }
        
        if secondsTotal <= 0 {
            addRoundAndChangeTime()
            circularProgBar.value = 0
            countSeconds = 0.0
        }
    }
    
    func addRoundAndChangeTime(){
        if isBreak {
            secondsTotal = 1500
            getTimerUpdate.text = "25:00"
            isBreak = false
            circularProgBar.progressColor = UIColor(red: 0.92, green: 0.77, blue: 0.21, alpha: 1.00)
            circularProgBar.progressStrokeColor = UIColor(red: 0.92, green: 0.77, blue: 0.21, alpha: 1.00)
        }else{
            roundCount += 1
            if roundCount == 4 {
                secondsTotal = 1200
                getTimerUpdate.text = "20:00"
                roundCount = 0
                totalRoundsCount.text = "\(roundCount)/4"
            }else{
                totalRoundsCount.text = "\(roundCount)/4"
                secondsTotal = 300
                getTimerUpdate.text = "05:00"
            }
            isBreak = true
            circularProgBar.progressColor = UIColor(red: 0.39, green: 0.71, blue: 0.67, alpha: 1.00)
            circularProgBar.progressStrokeColor = UIColor(red: 0.39, green: 0.71, blue: 0.67, alpha: 1.00)
        }
        
        isPaused = true
        circularProgBar.maxValue = CGFloat(secondsTotal)
        buttonStartOrPause.setImage(playImage, for: .normal)
        timer.invalidate()
    }
    
    @objc func appAgainActive() -> Bool {
        countActive += 1
        if(countActive > 1){
            endDate = Date()
            againActive = true
        }
        return againActive
    }
    
    @objc func appInBackGround(){
        startDate = Date()
    }
}

