//
//  TimezoneInterfaceController.swift
//  Exercise1
//
//  Created by Jose Angel Cuadrado on 8/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class TimezoneInterfaceController: WKInterfaceController {

    @IBOutlet var date: WKInterfaceDate!
    @IBOutlet var switchObject: WKInterfaceSwitch!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        setTitle("Timezone")
    }
    
    override func willActivate() {
        super.willActivate()
        switchObject.setOn(true)
        date.setTimeZone(NSTimeZone(abbreviation: "GMT"))
    }

    @IBAction func changeFormat(value: Bool) {
        let timezone: String = value ? "GMT" : "PST"
        date.setTimeZone(NSTimeZone(abbreviation: timezone))
    }

}
