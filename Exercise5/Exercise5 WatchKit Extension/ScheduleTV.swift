//
//  ScheduleTV.swift
//  Exercise5
//
//  Created by Jose Angel Cuadrado on 22/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import Foundation

class ScheduleTV {
    
    let userDefaults = NSUserDefaults(suiteName: "exercise5")
    
    var schedule: Dictionary<String, AnyObject>? {
        get {
            return userDefaults?.objectForKey("schedule") as? Dictionary<String, AnyObject>
        }
        set (value) {
            userDefaults?.setObject(value, forKey: "schedule")
            userDefaults?.synchronize()
        }
    }
    
}