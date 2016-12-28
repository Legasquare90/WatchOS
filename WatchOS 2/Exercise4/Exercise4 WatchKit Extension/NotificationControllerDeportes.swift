//
//  NotificationControllerDeportes.swift
//  Exercise4 WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 15/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class NotificationControllerDeportes: WKUserNotificationInterfaceController {

    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var bodyLabel: WKInterfaceLabel!
    @IBOutlet var nameTeam1Label: WKInterfaceLabel!
    @IBOutlet var scoreTeam1Label: WKInterfaceLabel!
    @IBOutlet var nameTeam2Label: WKInterfaceLabel!
    @IBOutlet var scoreTeam2Label: WKInterfaceLabel!
    
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
        
        let nameTeam1 = remoteNotification["equipo1"] as! String
        let nameTeam2 = remoteNotification["equipo2"] as! String
        let scoreTeam1 = remoteNotification["equipo1_score"] as! Int
        let scoreTeam2 = remoteNotification["equipo2_score"] as! Int
        
        titleLabel.setText("\(title!)")
        bodyLabel.setText("\(body!)")
        nameTeam1Label.setText(nameTeam1)
        scoreTeam1Label.setText("\(scoreTeam1)")
        nameTeam2Label.setText(nameTeam2)
        scoreTeam2Label.setText("\(scoreTeam2)")
        
        completionHandler(.Custom)
    }

}
