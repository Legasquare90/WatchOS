//
//  HeartRateInterfaceController.swift
//  Exercise7
//
//  Created by Jose Angel  Cuadrado Mingo on 31/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import HealthKit

class HeartRateInterfaceController: WKInterfaceController {

    @IBOutlet var heartLabel: WKInterfaceLabel!
    @IBOutlet var stopButton: WKInterfaceButton!
    @IBOutlet var startButton: WKInterfaceButton!
    
    let healthStore = HKHealthStore()
    let heartRateUnit = HKUnit(fromString: "count/min")
    
    let query:HKAnchoredObjectQuery = HKAnchoredObjectQuery(
        type: HKObjectType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate)!,
        predicate: nil,
        anchor: HKQueryAnchor(fromValue: Int(HKAnchoredObjectQueryNoAnchor)),
        limit: Int(HKObjectQueryNoLimit)) {
            (query: HKAnchoredObjectQuery,
            sampleObjects: [HKSample]?,
            deletedObjets: [HKDeletedObject]?,
            newANchor: HKQueryAnchor?,
            error: NSError?) -> Void in
            
    }
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.setTitle("Heart Rate")
        self.stopButton.setEnabled(false)
        self.query.updateHandler = {
            (query: HKAnchoredObjectQuery,
            sampleObjects: [HKSample]?,
            deletedObjets: [HKDeletedObject]?,
            newANchor: HKQueryAnchor?,
            error: NSError?) -> Void in
                self.updateHeartRate(sampleObjects)
        }
    }

    @IBAction func startButtonAction() {
        healthStore.executeQuery(query)
        self.heartLabel.setText("Obteniendo pulso...")
        self.stopButton.setEnabled(true)
        self.startButton.setEnabled(false)
    }
    
    @IBAction func stopButtonAction() {
        healthStore.stopQuery(query)
        self.heartLabel.setText("---")
        self.stopButton.setEnabled(false)
        self.startButton.setEnabled(true)
    }
    
    func updateHeartRate(samples: [HKSample]?) {
        guard let heartRateSamples = samples as? [HKQuantitySample] else {
            return
        }
        
        dispatch_async(dispatch_get_main_queue()) {
            guard let heartRate = heartRateSamples.first else {
                self.heartLabel.setText("Pulso no disponible")
                return
            }
            self.heartLabel.setText("\(Int(heartRate.quantity.doubleValueForUnit(self.heartRateUnit))) PPM")
        }
    }
    
}
