//
//  SendMessageInterfaceController.swift
//  Exercise9
//
//  Created by Jose Angel Cuadrado on 8/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class SendMessageInterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var counterLabel: WKInterfaceLabel!
    @IBOutlet var savedLabel: WKInterfaceLabel!
    
    let session: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil
    
    var counter: Int = 0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        session?.delegate = self
        session?.activateSession()
    }

    @IBAction func hitAction() {
        counter++
        counterLabel.setText("\(counter)")
        savedLabel.setHidden(true)
    }
    
    @IBAction func clearAction() {
        counter = 0
        counterLabel.setText("\(counter)")
        savedLabel.setHidden(true)
    }
    
    @IBAction func saveAction() {
        let dict = ["counter":counter]
        if (session?.reachable == true) {
            session?.sendMessage(dict, replyHandler: { (response: [String : AnyObject]) -> Void in
                    print(response)
                if response["reply"] as! String == "OK" {
                    self.savedLabel.setHidden(false)
                }
                }, errorHandler: { (error: NSError) -> Void in
                    print("Error: \(error.localizedDescription)")
            })
        } else {
            print("session not reachable")
        }
    }
}
