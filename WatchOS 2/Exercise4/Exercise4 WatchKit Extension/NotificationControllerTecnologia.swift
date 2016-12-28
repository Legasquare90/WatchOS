//
//  NotificationControllerTecnologia.swift
//  Exercise4
//
//  Created by Jose Angel Cuadrado on 17/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class NotificationControllerTecnologia: WKUserNotificationInterfaceController {

    @IBOutlet var image: WKInterfaceImage!
    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var bodyLabel: WKInterfaceLabel!
    
    override init() {
        // Initialize variables here.
        super.init()
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    override func didReceiveRemoteNotification(remoteNotification: [NSObject : AnyObject], withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        
        let aps = remoteNotification["aps"] as! Dictionary<String, AnyObject>
        
        guard let alert = aps["alert"] else {
            completionHandler(.Default)
            return
        }
        guard let title = alert["title"] else {
            completionHandler(.Default)
            return
        }
        guard let body = alert["body"] else {
            completionHandler(.Default)
            return
        }
        
        let image = remoteNotification["image"] as! String
        
        titleLabel.setText("\(title!)")
        bodyLabel.setText("\(body!)")
        self.image.setImageNamed(image)
        
        completionHandler(.Custom)
        
    }
    
}
