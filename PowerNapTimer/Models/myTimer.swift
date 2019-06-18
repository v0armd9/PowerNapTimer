//
//  myTimer.swift
//  PowerNapTimer
//
//  Created by Darin Marcus Armstrong on 6/18/19.
//  Copyright © 2019 Darin Marcus Armstrong. All rights reserved.
//

import Foundation

protocol MyTimerDelegate: class {
    func timerCompleted()
    func timerStopped()
    func timerSecondTicked()
}

class MyTimer: NSObject {
    
    // How many seconds remain on timer?
    var timeRemaining: TimeInterval?
    // Timer object we are hiding behind our rapper.
    var timer: Timer?
    
    weak var delegate: MyTimerDelegate?
    // Indicates whether the timer is running or not
    var isOn: Bool {
        if timeRemaining != nil {
            return true
        } else {
            return false
        }
    }
    
    private func secondTicked() {
        guard let timeRemaining = timeRemaining else {return}
        if timeRemaining > 0 {
            self.timeRemaining = timeRemaining - 1
            delegate?.timerSecondTicked()
            print(timeRemaining)
        } else {
            timer?.invalidate()
            self.timeRemaining = nil
            delegate?.timerCompleted()
        }
    }
    
    func startTimer(time: TimeInterval) {
        if isOn == false {
            self.timeRemaining = time
            
            self.timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true, block: { (_) in
                self.secondTicked()
            })
        }
    }
    
    func stopTimer() {
        if isOn {
            self.timeRemaining = nil
            timer?.invalidate()
            delegate?.timerStopped()
            
        }
    }
}
