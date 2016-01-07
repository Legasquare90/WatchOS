//
//  ExtensionDelegate.swift
//  Exercise9 WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 5/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import WatchConnectivity

class ExtensionDelegate: NSObject, WKExtensionDelegate, WCSessionDelegate {

    let session: WCSession? = WCSession.isSupported() ? WCSession.defaultSession() : nil

    func applicationDidFinishLaunching() {
        session?.delegate = self
        session?.activateSession()
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }
    
    func session(session: WCSession, didReceiveFile file: WCSessionFile) {
        let imageData = NSData(contentsOfURL: file.fileURL)!
        NSUserDefaults.standardUserDefaults().setObject(imageData, forKey: "item")
    }

}
