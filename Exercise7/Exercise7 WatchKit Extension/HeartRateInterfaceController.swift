//
//  HeartRateInterfaceController.swift
//  Exercise7
//
//  Created by Jose Angel  Cuadrado Mingo on 31/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class HeartRateInterfaceController: WKInterfaceController {

    @IBOutlet var heartLabel: WKInterfaceLabel!
    @IBOutlet var stopButton: WKInterfaceButton!
    @IBOutlet var startButton: WKInterfaceButton!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func startButtonAction() {
        
    }
    
    @IBAction func stopButtonAction() {
        
    }
}
