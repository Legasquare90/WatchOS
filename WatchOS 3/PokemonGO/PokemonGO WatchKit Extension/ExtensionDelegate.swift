//
//  ExtensionDelegate.swift
//  PokemonGO WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 3/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import WatchConnectivity

class ExtensionDelegate: NSObject, WKExtensionDelegate, WCSessionDelegate {

    func applicationDidFinishLaunching() {
        let pokeballData = ["name": "pokeball", "ratio":1.0, "price":1] as [String : Any]
        let superballData = ["name": "superball", "ratio":2.0, "price":3] as [String : Any]
        let ultraballData = ["name": "ultraball", "ratio":4.0, "price":5] as [String : Any]
        let ballTypes = [pokeballData, superballData, ultraballData]
        
        let userDefaults = UserDefaults.standard
        userDefaults.set(ballTypes, forKey: "ballTypes")
        userDefaults.synchronize()
        
        let session: WCSession? = WCSession.isSupported() ? WCSession.default() : nil
        session?.delegate = self
        session?.activate()
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if (error != nil) {
            print(error.debugDescription)
        } else {
            print("Activation completed")
        }
    }
    
    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                backgroundTask.setTaskCompleted()
            case let snapshotTask as WKSnapshotRefreshBackgroundTask:
                // Snapshot tasks have a unique completion call, make sure to set your expiration date
                snapshotTask.setTaskCompleted(restoredDefaultState: true, estimatedSnapshotExpiration: Date.distantFuture, userInfo: nil)
            case let connectivityTask as WKWatchConnectivityRefreshBackgroundTask:
                // Be sure to complete the connectivity task once you’re done.
                connectivityTask.setTaskCompleted()
            case let urlSessionTask as WKURLSessionRefreshBackgroundTask:
                // Be sure to complete the URL session task once you’re done.
                urlSessionTask.setTaskCompleted()
            default:
                // make sure to complete unhandled task types
                task.setTaskCompleted()
            }
        }
    }

}
