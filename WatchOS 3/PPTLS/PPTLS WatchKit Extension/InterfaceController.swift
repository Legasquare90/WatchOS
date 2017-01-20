//
//  InterfaceController.swift
//  PPTLS WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 20/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion

class InterfaceController: WKInterfaceController {

    let motionManager = CMMotionManager()
    var count = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setupAccelerometer()
    }
    
    func setupAccelerometer() {
        guard motionManager.isDeviceMotionAvailable else {
            print("DeviceMotion no disponible")
            return
        }
        
        motionManager.deviceMotionUpdateInterval = 0.1
        
        motionManager.startDeviceMotionUpdates(to: OperationQueue.current!, withHandler:{
            data, error in
            
            let userAcceleration = data?.userAcceleration
            
            let userX = userAcceleration?.x
            let userY = userAcceleration?.y
            let userZ = userAcceleration?.z
            
            print("User X: \(userX!)")
            print("User Y: \(userY!)")
            print("User Z: \(userZ!)")
            print()
            
            if (userY! > 1.0 || userY! < -1) {
                self.count += 1
            }
            
            if (self.count >= 5) {
                print("FINISH")
                self.motionManager.stopDeviceMotionUpdates()
            }

        })
        
    }

}
