//
//  ExtensionDelegate.swift
//  ElMundoToday WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 2/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate, URLSessionTaskDelegate {

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
    }

    func applicationDidBecomeActive() {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillResignActive() {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, etc.
    }

    func handle(_ backgroundTasks: Set<WKRefreshBackgroundTask>) {
        // Sent when the system needs to launch the application in the background to process tasks. Tasks arrive in a set, so loop through and process each one.
        for task in backgroundTasks {
            // Use a switch statement to check the task type
            switch task {
            case let backgroundTask as WKApplicationRefreshBackgroundTask:
                // Be sure to complete the background task once you’re done.
                beginDownloadTask()
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
    
    func beginDownloadTask() {
        print("Init task")
        let url = URL(string: "http://private-66576-elmundotodayupsa.apiary-mock.com/news")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        let config = URLSessionConfiguration.background(withIdentifier: "newsElMundoToday")
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        let task: URLSessionDataTask = session.dataTask(with: urlRequest) { (dataResponse, urlResponse, errorResponse) in
            guard errorResponse == nil else {
                print("dataTask fail: \(errorResponse!.localizedDescription)")
                return
            }
            guard let data = dataResponse else {
                print("dataTask fail: not received data")
                return
            }
//            do {
//                guard let pokemonNearby = try JSONSerialization.jsonObject(with: data, options: []) as? [Dictionary<String, Any>] else {
//                    throw PokemonNearbyError.parseError
//                }
//                self.pokemonNearby = pokemonNearby
//                self.setupTable()
//                print(pokemonNearby)
//            } catch {
//                print("dataTask fail: error parsing JSON")
//                return
//            }
        }
        task.resume()
    }

}
