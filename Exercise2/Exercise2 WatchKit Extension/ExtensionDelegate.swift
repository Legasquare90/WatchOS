//
//  ExtensionDelegate.swift
//  Exercise2 WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 8/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        let objects = [["name":"UPSA", "latitude":40.962009, "longitude":-5.665677], ["name":"IGZ", "latitude":40.421322, "longitude":-3.705472], ["name":"T3chFest (UC3M)", "latitude":40.332143, "longitude":-3.835696]]
        let controllers = Array(count: objects.count, repeatedValue: "map")
        WKInterfaceController.reloadRootControllersWithNames( controllers, contexts: nil)
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

}
