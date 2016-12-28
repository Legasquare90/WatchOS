//
//  TransferUserInfoInterfaceController.swift
//  Exercise9
//
//  Created by Jose Angel Cuadrado on 7/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class TransferUserInfoInterfaceController: WKInterfaceController, WCSessionDelegate {

    let session: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        session?.delegate = self
        session?.activateSession()
    }

    @IBAction func appleAction() {
        sendEmoji("🍎")
    }
    
    @IBAction func pearAction() {
        sendEmoji("🍐")
    }
    
    @IBAction func orangeAction() {
        sendEmoji("🍊")
    }
    
    @IBAction func bananaAction() {
        sendEmoji("🍌")
    }
    
    @IBAction func cherryAction() {
        sendEmoji("🍒")
    }
    
    @IBAction func pineappleAction() {
        sendEmoji("🍍")
    }
    
    func sendEmoji(emoji: String) {
        let dict = ["emoji": emoji]
        session?.transferUserInfo(dict)
    }
    
    func session(session: WCSession, didFinishUserInfoTransfer userInfoTransfer: WCSessionUserInfoTransfer, error: NSError?) {
        print("error: \(error?.localizedDescription)")
    }
    
}
