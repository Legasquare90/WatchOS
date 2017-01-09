//
//  InterfaceController.swift
//  ElMundoToday WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 2/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if (context == nil) {
            let contexts = Array(repeating: ["Test"], count: 5)
            let controllers = Array(repeating: "interface", count: 5)
            WKInterfaceController.reloadRootControllers(withNames: controllers, contexts: contexts)
        } else {
            print(context!)
        }
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
