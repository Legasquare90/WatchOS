//
//  ViewController.swift
//  Exercise9
//
//  Created by Jose Angel Cuadrado on 5/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import UIKit
import WatchConnectivity

class ViewController: UIViewController, WCSessionDelegate {

    @IBOutlet weak var updateApplicationContextLabel: UILabel!
    
    @IBOutlet weak var transferUserInfoLabel: UILabel!
    
    let session: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session?.delegate = self;
        session?.activateSession()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func session(session: WCSession, didReceiveApplicationContext applicationContext: [String : AnyObject]) {
        let emoji = applicationContext["emoji"] as? String

        dispatch_async(dispatch_get_main_queue()) {
            if let emoji = emoji {
                self.updateApplicationContextLabel.text = "Last emoji: \(emoji)"
            }
        }
    }
    
    func session(session: WCSession, didReceiveUserInfo userInfo: [String : AnyObject]) {
        let emoji = userInfo["emoji"] as? String
        
        dispatch_async(dispatch_get_main_queue()) {
            if let emoji = emoji {
                self.transferUserInfoLabel.text = "Last emoji: \(emoji)"
            }
        }
    }
    
}

