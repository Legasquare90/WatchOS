//
//  AccelerometerInterfaceController.swift
//  Exercise7
//
//  Created by Jose Angel Cuadrado on 29/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion


class AccelerometerInterfaceController: WKInterfaceController {

    @IBOutlet var axisXLabel: WKInterfaceLabel!
    @IBOutlet var axisYLabel: WKInterfaceLabel!
    @IBOutlet var axisZLabel: WKInterfaceLabel!
    
    let motionManager = CMMotionManager()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.setTitle("Acelerómetro")
        self.axisXLabel.setText("X: --")
        self.axisYLabel.setText("Y: --")
        self.axisZLabel.setText("Z: --")
    }
    
    override func willActivate() {
        super.willActivate()
        setupAccelerometer()
    }
    
    func setupAccelerometer() {
        guard motionManager.accelerometerAvailable else {
            print("Acelerómetro no disponible")
            return
        }
        
        motionManager.accelerometerUpdateInterval = 0.1
        motionManager.startAccelerometerUpdatesToQueue(NSOperationQueue.mainQueue()) { (data: CMAccelerometerData?, error: NSError?) -> Void in
            
            let acceleration = data?.acceleration
            
            let accelerationX = acceleration?.x
            let accelerationY = acceleration?.y
            let accelerationZ = acceleration?.z
            
            self.axisXLabel.setText("X: \(accelerationX!)")
            self.axisYLabel.setText("Y: \(accelerationY!)")
            self.axisZLabel.setText("Z: \(accelerationZ!)")
            
        }
    }

}
