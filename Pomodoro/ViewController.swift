//
//  ViewController.swift
//  Pomodoro
//
//  Created by Daniel Flores on 23/06/20.
//  Copyright © 2020 Daniel Flores. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let formatter = DateFormatter()
    let date = Date()
    
    
    @IBOutlet weak var getCurrentDate: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func startTime(_ sender: Any) {
        formatter.dateFormat = "dd-MM-yyyy"
        getCurrentDate.text = formatter.string(from: date)
    }
    
}

