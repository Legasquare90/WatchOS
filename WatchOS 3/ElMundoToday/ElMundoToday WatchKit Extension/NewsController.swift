//
//  NewsController.swift
//  ElMundoToday WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 2/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation

class NewsController: WKInterfaceController {
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        if (context == nil) {
            let contexts = Array(repeating: ["Test"], count: 5)
            let controllers = Array(repeating: "NewsController", count: 5)
            WKInterfaceController.reloadRootControllers(withNames: controllers, contexts: contexts)
        } else {
            print(context!)
        }
    }

}
