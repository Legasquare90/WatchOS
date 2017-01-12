//
//  NewsNotificationController.swift
//  ElMundoToday WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 2/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications


class NewsNotificationController: WKUserNotificationInterfaceController {

    @IBOutlet var textNotification: WKInterfaceLabel!
    @IBOutlet var imageNotification: WKInterfaceImage!

    override func didReceive(_ notification: UNNotification, withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Swift.Void) {
        
        let userInfo = notification.request.content.userInfo
        if let dataImage = try? Data(contentsOf: URL(string: userInfo["image"] as! String)!) {
            imageNotification.setImageData(dataImage)
        } else {
            completionHandler(.default)
        }
        textNotification.setText(notification.request.content.body)
        completionHandler(.custom)
    }
}
