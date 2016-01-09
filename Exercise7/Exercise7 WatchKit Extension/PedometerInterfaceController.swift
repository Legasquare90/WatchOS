//
//  PedometerInterfaceController.swift
//  Exercise7
//
//  Created by Jose Angel Cuadrado on 9/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import CoreMotion


class PedometerInterfaceController: WKInterfaceController {

    @IBOutlet var stepsLabel: WKInterfaceLabel!
    @IBOutlet var distanceLabel: WKInterfaceLabel!
    @IBOutlet var floorDescendedLabel: WKInterfaceLabel!
    @IBOutlet var floorAscendedLabel: WKInterfaceLabel!
    
    let pedometer = CMPedometer()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.setTitle("Pedometer")
        self.stepsLabel.setText("Steps: --")
        self.distanceLabel.setText("Distance: --")
        self.floorAscendedLabel.setText("Floor Asc: --")
        self.floorDescendedLabel.setText("Floor Desc: --")
    }

    override func willActivate() {
        super.willActivate()
        
        if (CMPedometer.isPaceAvailable()) {
            pedometer.startPedometerUpdatesFromDate(NSDate(), withHandler: { (pedometerData, error) -> Void in
                if (pedometerData != nil) {
                    self.stepsLabel.setText("Steps: \(pedometerData!.numberOfSteps)")
                    self.distanceLabel.setText("Distance: \(pedometerData!.distance)")
                    self.floorAscendedLabel.setText("Floor Asc: \(pedometerData!.floorsAscended)")
                    self.floorDescendedLabel.setText("Floor Desc: \(pedometerData!.floorsDescended)")
                }
            })
        } else {
            print("Pedometer pace not available")
        }
    }

    override func didDeactivate() {
        pedometer.stopPedometerUpdates()
        super.didDeactivate()
    }

}
