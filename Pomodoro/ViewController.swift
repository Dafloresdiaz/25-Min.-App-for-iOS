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
    //25 min are 1500 seconds
    var secondsTotal = 60
    
    let getDateString = getDate()
    var timer = Timer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getCurrentDate.text = getDateString.getDateStringFormat()
        
    }
    
    @IBAction func startTime(_ sender: Any) {
        timer = Timer.scheduledTimer(timeInterval: 1.0,
                                     target: self,
                                     selector: #selector(getTimerRunning),
                                     userInfo: nil, repeats: true)
    }
    
    @objc func getTimerRunning(){
        if (secondsTotal > 0){
            let minutes = Int(secondsTotal / 60 % 60)
            let seconds = Int(secondsTotal % 60)
            
            if (minutes < 10){
                getTimerUpdate.text = "0\(minutes):\(seconds)"
            }
            if (minutes < 10 && seconds < 10) {
                getTimerUpdate.text = "0\(minutes):0\(seconds)"
            }
            secondsTotal -= 1
        } else {
            secondsTotal = 300
            getTimerUpdate.text = "05:00"
        }
    }
    
}

