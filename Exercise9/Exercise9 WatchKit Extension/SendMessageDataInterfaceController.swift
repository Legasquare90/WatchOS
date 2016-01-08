//
//  SendMessageDataInterfaceController.swift
//  Exercise9
//
//  Created by Jose Angel Cuadrado on 8/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity


class SendMessageDataInterfaceController: WKInterfaceController, WCSessionDelegate {

    @IBOutlet var errorLabel: WKInterfaceLabel!
    @IBOutlet var image: WKInterfaceImage!
    
    let session: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        session?.delegate = self
        session?.activateSession()
    }
    
    func session(session: WCSession, didReceiveMessageData messageData: NSData) {
        self.errorLabel.setHidden(true)
        self.image.setHidden(false)
        self.image.setImage(UIImage(data: messageData))
    }

}
