//
//  HomeInterfaceController.swift
//  DemoApuestasTerminado WatchKit Extension
//
//  Created by Jose Angel Cuadrado Mingo on 13/5/15.
//  Copyright (c) 2015 IGZ. All rights reserved.
//

import WatchKit
import Foundation


class HomeInterfaceController: WKInterfaceController {

    @IBOutlet weak var lblName: WKInterfaceLabel!
    @IBOutlet weak var lblMoney: WKInterfaceLabel!
    @IBOutlet weak var lblStatus: WKInterfaceLabel!
    
    var numberOfBetsPlaced = 0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        setTitle("IGZ Bets")
        lblStatus.setHidden(true)
        numberOfBetsPlaced = UserStore.sharedInstance.betsPlaced.count
        
        communicateWithIPhone()
    }

    override func willActivate() {
        super.willActivate()
        
        setInterface()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }
    
    @IBAction func btnBetAction() {
        pushControllerWithName("bets_table", context: nil)
    }
    
    @IBAction func btnMapsMenu() {
        let objects = [["name":"IGZ Spain", "latitude":40.421322, "longitude":-3.705472], ["name":"IGZ USA", "latitude":37.776284, "longitude":-122.396506]]
        let controllers = Array(count: objects.count, repeatedValue: "location")
        presentControllerWithNames(controllers, contexts: objects)
    }
    
    override func handleActionWithIdentifier(identifier: String?, forRemoteNotification remoteNotification: [NSObject : AnyObject]) {
        let local = remoteNotification["local"] as! String
        let visitant = remoteNotification["visitant"] as! String
        let game = ["local":local, "visitant": visitant]
        pushControllerWithName("bet", context: game)
    }
    
    override func handleUserActivity(userInfo: [NSObject : AnyObject]?) {
        let controller = userInfo!["controllerName"] as! String
        pushControllerWithName(controller, context: nil)
    }
    
    func communicateWithIPhone() {
        HomeInterfaceController.openParentApplication(["task" : "getUserInfo"]) { (replyInfo: [NSObject : AnyObject]!, error: NSError!) -> Void in
            if (replyInfo != nil) { NSLog("%@", replyInfo!) }
            else { NSLog("%@", error!.description) }
            
            if let name = replyInfo["name"] as? String {
                UserStore.sharedInstance.name = name
            }
            if let money = replyInfo["money"] as? Int {
                UserStore.sharedInstance.money = money
            }
            if let bets = replyInfo["bets"] as? Array<Dictionary<String, AnyObject>> {
                UserStore.sharedInstance.bets = bets
            }
            self.setInterface()
        }
    }
    
    func setInterface() {
        lblName.setText("¡Hola \(UserStore.sharedInstance.name)!")
        lblMoney.setText("\(UserStore.sharedInstance.money) €")
        
        var betsPlaced = UserStore.sharedInstance.betsPlaced.count
        if (betsPlaced != numberOfBetsPlaced) {
            numberOfBetsPlaced = betsPlaced
            lblStatus.setHidden(false)
        } else {
            lblStatus.setHidden(true)
        }
    }

}
