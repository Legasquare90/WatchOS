//
//  ExtensionDelegate.swift
//  Exercise7 WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 29/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import HealthKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    let healthKitStore = HKHealthStore()
    
    func applicationDidFinishLaunching() {
        
        guard HKHealthStore.isHealthDataAvailable() == true else {
            print("Health data unavailable")
            return
        }
        
        guard let typeToRead = HKQuantityType.quantityTypeForIdentifier(HKQuantityTypeIdentifierHeartRate) else {
            print("Heart rate unavailable")
            return
        }
        
        let typesToRead = Set(arrayLiteral: typeToRead)
        
        healthKitStore.requestAuthorizationToShareTypes(nil, readTypes: typesToRead) { (success: Bool, error: NSError?) -> Void in
            if success {
                print("View authorization shown")
            }
        }
    }

}
