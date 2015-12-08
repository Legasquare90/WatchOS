//
//  TimerInterfaceController.swift
//  Exercise1
//
//  Created by Jose Angel Cuadrado on 8/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class TimerInterfaceController: WKInterfaceController {

    @IBOutlet var timer: WKInterfaceTimer!
    @IBOutlet var image: WKInterfaceImage!
    @IBOutlet var startButton: WKInterfaceButton!
    
    var doneTimer: NSTimer?
    var durationCounter: Int?
    var duration: Int?
    var stopped = true
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        setTitle("Timer")
        
        startButton.setTitle("Start")
        image.setImageNamed("wait")
        timer.setHidden(true)
        
        duration = 30
        durationCounter = duration
        doneTimer = NSTimer.scheduledTimerWithTimeInterval(1, target: self, selector: Selector("handleTimer:"), userInfo: nil, repeats: true)
    }

    override func didDeactivate() {
        super.didDeactivate()
        
        timer.stop()
        durationCounter = 0
        doneTimer?.invalidate()
        doneTimer = nil
        stopped = true
    }

    @IBAction func startButtonAction() {
        
        if (stopped) {
            startButton.setTitle("Stop")
            stopped = false
            timer.setHidden(false)
            timer.setDate(NSDate(timeIntervalSinceNow: NSTimeInterval(durationCounter!)))
            timer.start()
        } else {
            startButton.setTitle("Start")
            stopped = true
            timer.stop()
        }
        
    }
    
    func handleTimer(timer: NSTimer) {
        
        if (!stopped) {
            
            durationCounter!--
            
            if (durationCounter <= 0) {
                self.timer.setHidden(true)
                self.timer.stop()
                image.setImageNamed("tick")
                startButton.setTitle("Time's up!")
                startButton.setEnabled(false)
                durationCounter = duration
                stopped = true
            }
        }
        
    }
    
}
