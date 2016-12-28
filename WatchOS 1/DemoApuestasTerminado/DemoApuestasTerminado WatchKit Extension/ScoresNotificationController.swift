//
//  ScoresNotificationController.swift
//  DemoApuestasTerminado
//
//  Created by Jose Angel Cuadrado on 19/5/15.
//  Copyright (c) 2015 IGZ. All rights reserved.
//

import WatchKit
import Foundation


class ScoresNotificationController: WKUserNotificationInterfaceController {

    @IBOutlet weak var lblTitle: WKInterfaceLabel!
    @IBOutlet weak var lblLocal: WKInterfaceLabel!
    @IBOutlet weak var lblScoreLocal: WKInterfaceLabel!
    @IBOutlet weak var lblVisitant: WKInterfaceLabel!
    @IBOutlet weak var lblScoreVisitant: WKInterfaceLabel!
    
    override init() {
        super.init()
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    override func didReceiveRemoteNotification(remoteNotification: [NSObject : AnyObject], withCompletion completionHandler: ((WKUserNotificationInterfaceType) -> Void)) {
        
        let aps = remoteNotification["aps"] as! Dictionary<String, AnyObject>
        let alert = aps["alert"] as! Dictionary<String, AnyObject>
        let title = alert["title"] as! String
        
        let localLong = remoteNotification["localLong"] as! String
        let localScore = remoteNotification["localScore"] as! String
        let visitantLong = remoteNotification["visitantLong"] as! String
        let visitantScore = remoteNotification["visitantScore"] as! String
        
        lblTitle.setText(title)
        lblLocal.setText(localLong)
        lblScoreLocal.setText(localScore)
        lblVisitant.setText(visitantLong)
        lblScoreVisitant.setText(visitantScore)
        
        completionHandler(.Custom)
    }

}
