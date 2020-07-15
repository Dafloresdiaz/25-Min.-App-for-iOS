//
//  ViewController.swift
//  Pomodoro
//
//  Created by Daniel Flores on 23/06/20.
//  Copyright © 2020 Daniel Flores. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
    
    @IBOutlet weak var getCurrentDate: UILabel!
    @IBOutlet weak var getTimerUpdate: UILabel!
    @IBOutlet weak var buttonStartOrPause: UIButton!
    @IBOutlet weak var totalRoundsCount: UILabel!
    @IBOutlet weak var progressTimeBar: UIProgressView!
    
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
    var secondsTotal = 60
    var totalTime = 60
    var isBreak = false
    
    let getInfoDateTime = getDateAndTimeInfo()
    let createNotifications = configNotifications()
    let removeNotification = removeNotifications()
    
    var timer : Timer = Timer()
    
    //Function for the view Load
    override func viewDidLoad() {
        super.viewDidLoad()
        progressTimeBar.progress = 1
        getCurrentDate.text = getInfoDateTime.getDateStringFormat()
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
        
        if secondsTotal == 65 || secondsTotal == 90{
            totalTime = secondsTotal
            isBreak = true
        }else if secondsTotal == 60 {
            totalTime = secondsTotal
        }
        
        if(!isPaused && againActive){
            let secondBackground = getInfoDateTime.secondsBetweenDates(startDate: startDate, endDate: endDate)
            secondsTotal = secondsTotal + secondBackground
            againActive = false
        }
        
        secondsTotal -= 1
        
        progressTimeBar.setProgress((Float(secondsTotal)/Float(totalTime)), animated: true)
        
        let minutes = Int(secondsTotal / 60 % 60)
        let seconds = Int(secondsTotal % 60)
        
        if (minutes < 10){
            getTimerUpdate.text = "0\(minutes):\(seconds)"
        }
        if (minutes < 10 && seconds < 10) {
            getTimerUpdate.text = "0\(minutes):0\(seconds)"
        }
        
        if secondsTotal <= 0 {
            progressTimeBar.progress = 1
            addRoundAndChangeTime()
        }
    }
    
    func addRoundAndChangeTime(){
        if isBreak {
            secondsTotal = 60
            getTimerUpdate.text = "01:00"
            isBreak = false
        }else{
            roundCount += 1
            if roundCount == 4 {
                secondsTotal = 90
                getTimerUpdate.text = "01:30"
                roundCount = 0
                totalRoundsCount.text = "\(roundCount)/4"
            }else{
                totalRoundsCount.text = "\(roundCount)/4"
                secondsTotal = 65
                getTimerUpdate.text = "01:05"
            }
            isBreak = true
        }
        
        isPaused = true
        buttonStartOrPause.setImage(playImage, for: .normal)
        timer.invalidate()
    }
    
    @objc func appAgainActive() -> Bool {
        countActive += 1
        if(countActive > 1){
            endDate = Date()
            print(endDate)
            againActive = true
        }
        return againActive
    }
    
    @objc func appInBackGround(){
        startDate = Date()
        print(startDate)
    }
}

