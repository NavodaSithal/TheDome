//
//  TimerApplication.swift
//  iPay
//
//  Created by Thushara Wijekoon on 8/15/20.
//  Copyright © 2020 iPay. All rights reserved.
//

import UIKit

class TimerApplication: UIApplication {
    
    // the timeout in seconds, after which should perform custom actions
    // such as disconnecting the user
    private var timeoutInSeconds: TimeInterval {
        // 2 minutes
        return 300
    }
    
    private var idleTimer: Timer?
    
    // resent the timer because there was user interaction
    func resetIdleTimer() {
        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }
        
        idleTimer = Timer.scheduledTimer(timeInterval: timeoutInSeconds,
                                         target: self,
                                         selector: #selector(TimerApplication.timeHasExceeded),
                                         userInfo: nil,
                                         repeats: false
        )
    }
    
    func stopTimer(){
        print("timer stop")

        if let idleTimer = idleTimer {
            idleTimer.invalidate()
        }
    }
    
    // if the timer reaches the limit as defined in timeoutInSeconds, post this notification
    @objc private func timeHasExceeded() {
        NotificationCenter.default.post(name: .appTimeout,
                                        object: nil
        )
    }
    
    override func sendEvent(_ event: UIEvent) {
        
        super.sendEvent(event)
        
        if idleTimer != nil {
            self.resetIdleTimer()
        }
        
        if let touches = event.allTouches {
            for touch in touches where touch.phase == UITouch.Phase.began {
                self.resetIdleTimer()
            }
        }
    }
}

extension Notification.Name {

static let appTimeout = Notification.Name("appTimeout")
}
