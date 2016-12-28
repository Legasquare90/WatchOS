//
//  PhoneInterfaceController.swift
//  Exercise7
//
//  Created by Jose Angel Cuadrado on 3/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class PhoneInterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.setTitle("Phone")
    }

    @IBAction func callButtonAction() {
        WKExtension.sharedExtension().openSystemURL(NSURL(string: "tel:923277100")!)
    }
    
    @IBAction func smsButtonAction() {
        WKExtension.sharedExtension().openSystemURL(NSURL(string: "sms://651134379")!)
    }
    
}
