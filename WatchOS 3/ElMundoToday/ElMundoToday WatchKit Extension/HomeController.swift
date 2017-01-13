//
//  HomeController.swift
//  ElMundoToday
//
//  Created by Jose Angel Cuadrado on 13/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications

class HomeController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("EMT")
    }
    
    override func handleAction(withIdentifier identifier: String?, for notification: UNNotification) {
        if (notification.request.content.categoryIdentifier == "news") {
            let userInfo = notification.request.content.userInfo
            presentController(withName: "TextBodyNewsController", context: userInfo["textBody"])
        }
    }

}
