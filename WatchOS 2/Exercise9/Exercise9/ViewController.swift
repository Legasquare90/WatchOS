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
    
    @IBOutlet weak var sendMessageLabel: UILabel!
    
    let session: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        session?.delegate = self;
        session?.activateSession()
    }

    @IBAction func sendPhotoAction(sender: AnyObject) {
        let filePath = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("Apple Watch", ofType: "jpg")!)
        session?.transferFile(filePath, metadata: nil)
    }
    
    @IBAction func sendPhotoInstantAction(sender: AnyObject) {
        let filePath = NSURL.fileURLWithPath(NSBundle.mainBundle().pathForResource("apple-128", ofType: "png")!)
        let imageData = NSData(contentsOfURL: filePath)
        if (session?.reachable == true) {
            session?.sendMessageData(imageData!, replyHandler: nil, errorHandler: { (error: NSError) -> Void in
                print("Error: \(error.localizedDescription)")
            })
        } else {
            print("Session not reachable")
        }
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
    
    func session(session: WCSession, didFinishFileTransfer fileTransfer: WCSessionFileTransfer, error: NSError?) {
        print("error: \(error?.localizedDescription)")
    }
    
    func session(session: WCSession, didReceiveMessage message: [String : AnyObject], replyHandler: ([String : AnyObject]) -> Void) {
        let counter = message["counter"] as! Int
        dispatch_async(dispatch_get_main_queue()) {
            self.sendMessageLabel.text = "\(counter)"
        }
        let dict = ["reply":"OK"]
        replyHandler(dict)
    }
    
}

