//
//  ExtensionDelegate.swift
//  Exercise5 WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 20/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate {

    func applicationDidFinishLaunching() {
        ScheduleTV().schedule = ["Discovery Max":   [["name":"Wild Frank",
                                                    "img":"wild_frank",
                                                    "inicio":"09:00",
                                                    "fin":"14:00"],
                                                    ["name":"Top Gear",
                                                    "img":"top_gear",
                                                    "inicio":"14:00",
                                                    "fin":"00:00"],
                                                    ["name":"Cazasubastas",
                                                    "img":"cazasubastas",
                                                    "inicio":"00:00",
                                                    "fin":"09:00"]
                                                    ],
                                "Neox":             [["name":"Los Simpsons",
                                                    "img":"simpsons",
                                                    "inicio":"09:00",
                                                    "fin":"14:00"],
                                                    ["name":"Padre de familia",
                                                    "img":"padre_familia",
                                                    "inicio":"14:00",
                                                    "fin":"00:00"],
                                                    ["name":"El chiringuito de jugones",
                                                    "img":"chiringuito",
                                                    "inicio":"00:00",
                                                    "fin":"09:00"]
                                                    ]]
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

}
