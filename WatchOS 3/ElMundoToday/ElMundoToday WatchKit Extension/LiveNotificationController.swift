//
//  LiveNotificationController.swift
//  ElMundoToday
//
//  Created by Jose Angel Cuadrado on 12/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications


class LiveNotificationController: WKUserNotificationInterfaceController {

    @IBOutlet var statusLabel: WKInterfaceLabel!
    @IBOutlet var team1Name: WKInterfaceLabel!
    @IBOutlet var team1ScoreLabel: WKInterfaceLabel!
    @IBOutlet var team2Name: WKInterfaceLabel!
    @IBOutlet var team2ScoreLabel: WKInterfaceLabel!

    override func didReceive(_ notification: UNNotification, withCompletion completionHandler: @escaping (WKUserNotificationInterfaceType) -> Swift.Void) {

        let userInfo = notification.request.content.userInfo
        let equipo1 = userInfo["equipo1"] as! String
        let equipo2 = userInfo["equipo2"] as! String
        let equipo1_score = String(userInfo["equipo1_score"] as! Int)
        let equipo2_score = String(userInfo["equipo2_score"] as! Int)
        
        statusLabel.setText("FINAL")
        team1Name.setText(equipo1)
        team1ScoreLabel.setText(equipo1_score)
        team2Name.setText(equipo2)
        team2ScoreLabel.setText(equipo2_score)
        
        completionHandler(.custom)
    }
}
