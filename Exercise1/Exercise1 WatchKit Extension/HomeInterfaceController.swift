//
//  HomeInterfaceController.swift
//  Exercise1 WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 7/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class HomeInterfaceController: WKInterfaceController {

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.setTitle("Ejercicio 1")
    }

    @IBAction func startButtonAction() {
        let action1 = WKAlertAction(title: "OK", style: .Default, handler:{print("OK")})
        let action2 = WKAlertAction(title: "Destructive", style: .Destructive) {print("Destructive :(")}
        let action3 = WKAlertAction(title: "Cancel", style: .Cancel) {}
        
        presentAlertControllerWithTitle("No disponible", message: "", preferredStyle: .ActionSheet, actions: [action1, action2,action3])
    }
}
