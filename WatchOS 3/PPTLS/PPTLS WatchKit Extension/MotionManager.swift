//
//  MotionManager.swift
//  PPTLS
//
//  Created by Jose Angel Cuadrado on 21/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import CoreMotion

protocol MotionManagerDelegate: class {
    func armGestureDetected()
}

class MotionManager: NSObject {

    private let motionManager = CMMotionManager()
    private var count = 0
    
    weak var delegate: MotionManagerDelegate?

    func initAccelerometer() {
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
                self.delegate?.armGestureDetected()
            }
            
        })
    }
    
}
