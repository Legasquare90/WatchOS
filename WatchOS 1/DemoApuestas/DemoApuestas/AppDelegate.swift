//
//  AppDelegate.swift
//  DemoApuestas
//
//  Created by Jose Angel Cuadrado on 22/5/15.
//  Copyright (c) 2015 IGZ. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var userDefaults = NSUserDefaults.standardUserDefaults()


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let bet1 = ["local":"WAR", "visitant":"ROC", "hour":"18:00"]
        let bet2 = ["local":"LAK", "visitant":"CEL", "hour":"20:00"]
        let bet3 = ["local":"GRI", "visitant":"RAP", "hour":"21:00"]
        let arrayBets = [bet1, bet2, bet3]
        
        if (userDefaults.objectForKey("name") == nil) { userDefaults.setObject("Pepe", forKey: "name") }
        if (userDefaults.objectForKey("money") == nil) { userDefaults.setInteger(100, forKey: "money") }
        if (userDefaults.objectForKey("bets") == nil) { userDefaults.setObject(arrayBets, forKey: "bets") }
        
        registerSettingsAndCategories()
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }

    func application(application: UIApplication, handleWatchKitExtensionRequest userInfo: [NSObject : AnyObject]?, reply: (([NSObject : AnyObject]!) -> Void)!) {
        
        let task: String! = userInfo!["task"] as! String
        
        if (task == "getUserInfo") {
            let name: String = userDefaults.objectForKey("name") as! String
            let money: Int = userDefaults.objectForKey("money") as! Int
            let bets: Array = userDefaults.objectForKey("bets") as! Array<Dictionary<String, AnyObject>>
            reply(["name":name, "money":money, "bets": bets])
        } else if (task == "newBet") {
            userDefaults.setObject(userInfo!["money"], forKey: "money")
            userDefaults.setObject(userInfo!["betsPlaced"], forKey: "betsPlaced")
            NSNotificationCenter.defaultCenter().postNotificationName("newBet", object: nil)
        } else if (task == "getBetsPlaced") {
            let bets = userDefaults.objectForKey("betsPlaced") as! [Dictionary<String, AnyObject>]
            reply (["bets":bets])
        }
    }
    
    func registerSettingsAndCategories() {
        var categories = NSMutableSet()
        
        var betAction = UIMutableUserNotificationAction()
        betAction.title = "Apuesta"
        betAction.identifier = "betNotification"
        betAction.activationMode = UIUserNotificationActivationMode.Foreground
        betAction.authenticationRequired = false
        
        var inviteCategory = UIMutableUserNotificationCategory()
        inviteCategory.setActions([betAction], forContext: UIUserNotificationActionContext.Default)
        inviteCategory.identifier = "game"
        
        categories.addObject(inviteCategory)
        
        var settings = UIUserNotificationSettings(forTypes: (.Alert | .Badge | .Sound),
            categories: categories as Set<NSObject>)
        
        UIApplication.sharedApplication().registerUserNotificationSettings(settings)
    }
    
}

