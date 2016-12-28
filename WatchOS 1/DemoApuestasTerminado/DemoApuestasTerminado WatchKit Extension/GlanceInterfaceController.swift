//
//  GlanceInterfaceController.swift
//  DemoApuestasTerminado
//
//  Created by Jose Angel Cuadrado on 22/5/15.
//  Copyright (c) 2015 IGZ. All rights reserved.
//

import WatchKit
import Foundation


class GlanceInterfaceController: WKInterfaceController {

    @IBOutlet weak var lblNumberBets: WKInterfaceLabel!
    @IBOutlet weak var lblFirstBet: WKInterfaceLabel!
    @IBOutlet weak var lblSecondBet: WKInterfaceLabel!
    @IBOutlet weak var lblThirdBet: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.lblFirstBet.setHidden(true)
        self.lblSecondBet.setHidden(true)
        self.lblThirdBet.setHidden(true)
        GlanceInterfaceController.openParentApplication(["task" : "getBetsPlaced"], reply: { (replyInfo:[NSObject : AnyObject]!, error: NSError!) -> Void in
            if (replyInfo != nil) { NSLog("%@", replyInfo!) }
            else { NSLog("%@", error!.description) }
            
            let betsPlaced = replyInfo["bets"] as! [Dictionary<String, AnyObject>]
            self.lblNumberBets.setText("\(betsPlaced.count)")
            for(var i: Int=0; i<betsPlaced.count; i++) {
                switch (i) {
                case 0:
                    let bet = betsPlaced[i] as Dictionary<String, AnyObject>
                    let betAmount = bet["bet"] as! Int
                    let winner = bet["win"] as! String
                    self.lblFirstBet.setText("Ap: \(betAmount) € @ \(winner)")
                    self.lblFirstBet.setHidden(false)
                    self.lblFirstBet.setTextColor(UIColor.greenColor())
                case 1:
                    let bet = betsPlaced[i] as Dictionary<String, AnyObject>
                    let betAmount = bet["bet"] as! Int
                    let winner = bet["win"] as! String
                    self.lblSecondBet.setText("Ap: \(betAmount) € @ \(winner)")
                    self.lblSecondBet.setHidden(false)
                    self.lblSecondBet.setTextColor(UIColor.redColor())
                case 2:
                    let bet = betsPlaced[i] as Dictionary<String, AnyObject>
                    let betAmount = bet["bet"] as! Int
                    let winner = bet["win"] as! String
                    self.lblThirdBet.setText("Ap: \(betAmount) € @ \(winner)")
                    self.lblThirdBet.setHidden(false)
                default:
                    break
                }
            }
        })
        
    }

    override func willActivate() {
        super.willActivate()
        updateUserActivity("com.igz.apuestas.terminado.DemoApuestasTerminado", userInfo: ["controllerName":"bets_table"], webpageURL: nil)
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}
