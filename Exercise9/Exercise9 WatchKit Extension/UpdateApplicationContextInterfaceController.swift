//
//  UpdateApplicationContextInterfaceController.swift
//  Exercise9
//
//  Created by Jose Angel Cuadrado on 7/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class UpdateApplicationContextInterfaceController: WKInterfaceController, WCSessionDelegate {

    let session: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        session?.delegate = self
        session?.activateSession()
    }

    @IBAction func dogAction() {
        sendEmoji("🐶")
    }

    @IBAction func catAction() {
        sendEmoji("🐱")
    }

    @IBAction func mouseAction() {
        sendEmoji("🐭")
    }

    @IBAction func turtleAction() {
        sendEmoji("🐢")
    }

    @IBAction func fishAction() {
        sendEmoji("🐠")
    }

    @IBAction func lionAction() {
        sendEmoji("🦁")
    }
    
    func sendEmoji(emoji: String) {
        let dict = ["emoji": emoji]
        do {
            try session?.updateApplicationContext(dict)
        } catch {
            print(error)
        }
    }
    
}
