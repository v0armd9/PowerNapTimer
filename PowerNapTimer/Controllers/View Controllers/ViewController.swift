//
//  ViewController.swift
//  PowerNapTimer
//
//  Created by Darin Marcus Armstrong on 6/18/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var timerLabel: UILabel!
    @IBOutlet weak var napButton: UIButton!
    
    let timer = MyTimer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        timer.delegate = self
    }
    
    @IBAction func napButtonTapped(_ sender: UIButton) {
        if timer.isOn {
            timer.stopTimer()
        } else {
            timer.startTimer(time: 5)
        }
        updateButton()
        updateLabel()
    }
    
    func updateLabel() {
        if timer.isOn {
            timerLabel.text = "\(timer.timeRemaining)"
        } else {
            timerLabel.text = "20:00"
        }
    }
    
    func updateButton() {
        if timer.isOn {
            napButton.setTitle("Cancel Nap", for: .normal)
        } else {
            napButton.setTitle("Start Nap", for: .normal)
        }
    }
}

extension ViewController: MyTimerDelegate {
    func timerCompleted() {
        updateLabel()
        updateButton()
        //Call the display alert controller function
    }
    
    func timerStopped() {
        updateButton()
        updateLabel()
    }
    
    func timerSecondTicked() {
        updateLabel()
    }
}


