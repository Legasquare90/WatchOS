//
//  AppDelegate.swift
//  PokemonGO
//
//  Created by Jose Angel Cuadrado on 3/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import UIKit
import WatchConnectivity

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, WCSessionDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let session: WCSession? = WCSession.isSupported() ? WCSession.default() : nil
        session?.delegate = self
        session?.activate()

        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    public func session(_ session: WCSession, activationDidCompleteWith activationState: WCSessionActivationState, error: Error?) {
        if (error != nil) {
            print("Activation completed")
        } else {
            print(error.debugDescription)
        }
    }
    
    public func sessionDidDeactivate(_ session: WCSession) {
        
    }
    
    public func sessionDidBecomeInactive(_ session: WCSession) {
        
    }
    
    func session(_ session: WCSession, didReceiveMessage message: [String : Any], replyHandler: @escaping ([String : Any]) -> Void) {
        let action = message["action"] as? String
        if (action == "listPokemon") {
            let articunoData = ["name": "articuno", "cp":Int(arc4random_uniform(1000))+300, "hp":Int(arc4random_uniform(100))+100, "typeAttack": "ice", "attack" :"Ventisca", "powerAttack": 110] as [String : Any]
            let zapdosData = ["name": "zapdos", "cp":Int(arc4random_uniform(1000))+300, "hp":Int(arc4random_uniform(100))+100, "typeAttack": "electric", "attack" :"Trueno", "powerAttack": 110] as [String : Any]
            let moltresData = ["name": "moltres", "cp":Int(arc4random_uniform(1000))+300, "hp":Int(arc4random_uniform(100))+100, "typeAttack": "fire", "attack" :"Llamarada", "powerAttack": 110] as [String : Any]
            let listPokemon = [articunoData, zapdosData, moltresData]
            let replyData = ["listPokemon" : listPokemon]
            replyHandler(replyData)
        }
    }
}

