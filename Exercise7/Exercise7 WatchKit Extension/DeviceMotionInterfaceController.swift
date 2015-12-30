//
//  DeviceMotionInterfaceController.swift
//  Exercise7
//
//  Created by Jose Angel  Cuadrado Mingo on 30/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion


class DeviceMotionInterfaceController: WKInterfaceController {
    
    @IBOutlet var accXLabel: WKInterfaceLabel!
    @IBOutlet var accYLabel: WKInterfaceLabel!
    @IBOutlet var accZLabel: WKInterfaceLabel!
    @IBOutlet var roll: WKInterfaceLabel!
    @IBOutlet var pitch: WKInterfaceLabel!
    @IBOutlet var yaw: WKInterfaceLabel!
    @IBOutlet var rotXLabel: WKInterfaceLabel!
    @IBOutlet var rotYLabel: WKInterfaceLabel!
    @IBOutlet var rotZLabel: WKInterfaceLabel!
    @IBOutlet var gravXLabel: WKInterfaceLabel!
    @IBOutlet var gravYLabel: WKInterfaceLabel!
    @IBOutlet var gravZLabel: WKInterfaceLabel!
    
    let motionManager = CMMotionManager()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.setTitle("Acelerómetro")
        self.accXLabel.setText("Acc. X: --")
        self.accYLabel.setText("Acc. Y: --")
        self.accZLabel.setText("Acc. Z: --")
        self.roll.setText("Roll: --")
        self.pitch.setText("Pitch: --")
        self.yaw.setText("Yaw: --")
        self.rotXLabel.setText("Rot. X: --")
        self.rotYLabel.setText("Rot. Y: --")
        self.rotZLabel.setText("Rot. Z: --")
        self.gravXLabel.setText("Grav X: --")
        self.gravYLabel.setText("Grav Y: --")
        self.gravZLabel.setText("Grav Z: --")
    }
    
    override func willActivate() {
        super.willActivate()
        setupAccelerometer()
    }
    
    func setupAccelerometer() {
        guard motionManager.deviceMotionAvailable else {
            print("DeviceMotion no disponible")
            return
        }
        
        motionManager.deviceMotionUpdateInterval = 0.1
        motionManager.startDeviceMotionUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (data: CMDeviceMotion?, error: NSError?) -> Void in
            let attitude = data?.attitude
            let userAcceleration = data?.userAcceleration
            let rotationRate = data?.rotationRate
            let gravity = data?.gravity
            
            let roll = attitude?.roll
            let pitch = attitude?.pitch
            let yaw = attitude?.yaw
            
            let userX = userAcceleration?.x
            let userY = userAcceleration?.y
            let userZ = userAcceleration?.z
            
            let rotX = rotationRate?.x
            let rotY = rotationRate?.y
            let rotZ = rotationRate?.z
            
            let gravX = gravity?.x
            let gravY = gravity?.y
            let gravZ = gravity?.z
            
            self.roll.setText("Roll: \(roll!)")
            self.pitch.setText("Pitch: \(pitch!)")
            self.yaw.setText("Yaw: \(yaw!)")
            self.accXLabel.setText("User X: \(userX!)")
            self.accYLabel.setText("User Y: \(userY!)")
            self.accZLabel.setText("User Z: \(userZ!)")
            self.rotXLabel.setText("Rot X: \(rotX!)")
            self.rotYLabel.setText("Rot Y: \(rotY!)")
            self.rotZLabel.setText("Rot Z: \(rotZ!)")
            self.gravXLabel.setText("Grav X: \(gravX!)")
            self.gravYLabel.setText("Grav Y: \(gravY!)")
            self.gravZLabel.setText("Grav Z: \(gravZ!)")
        })
        
    }
    
}