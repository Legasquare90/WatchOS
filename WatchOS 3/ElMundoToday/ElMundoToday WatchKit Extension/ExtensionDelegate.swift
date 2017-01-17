//
//  ExtensionDelegate.swift
//  ElMundoToday WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 2/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit

class ExtensionDelegate: NSObject, WKExtensionDelegate, URLSessionDownloadDelegate {

    func applicationDidFinishLaunching() {
        // Perform any final initialization of your application.
        
        // Only for test happy-path
        UserDefaults.standard.removeObject(forKey: "videoID")
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
                beginDownloadTask(userInfo: backgroundTask.userInfo as! NSDictionary)
                
                // Only for test happy-path
                saveVideoID(userInfo: backgroundTask.userInfo as! NSDictionary)
                updateSnapshot()
                
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
    
    func saveVideoID(userInfo: NSDictionary) {
        let videoID = userInfo["videoID"] as! String
        let userDefaults = UserDefaults.standard
        var videoIDArray = userDefaults.object(forKey: "videoID") as? [String]
        if (videoIDArray == nil) {
            videoIDArray = [videoID]
            userDefaults.set(videoIDArray, forKey: "videoID")
            userDefaults.synchronize()
        } else {
            if (!videoIDArray!.contains(videoID)) {
                videoIDArray!.append(videoID)
                userDefaults.set(videoIDArray, forKey: "videoID")
                userDefaults.synchronize()
            }
        }
    }
    
    func beginDownloadTask(userInfo: NSDictionary) {
        let urlString = userInfo["url"] as! String
        print("Init task: \(urlString)")
        
        let url = URL(string: urlString)
        let config = URLSessionConfiguration.background(withIdentifier: NSUUID().uuidString)
        let session = URLSession(configuration: config, delegate: self, delegateQueue: nil)
        let task = session.downloadTask(with: url!)
        task.resume()
    }
    
    func updateSnapshot() {
        NotificationCenter.default.post(name: Notification.Name("updateSnapshot"), object: nil)
        WKExtension.shared().scheduleSnapshotRefresh(withPreferredDate: Date(), userInfo: nil) { error in
            if (error == nil) {
                print("successfully scheduled snapshot.  All background work completed.")
            }
        }
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didWriteData bytesWritten: Int64, totalBytesWritten: Int64, totalBytesExpectedToWrite: Int64) {
        print("Total bytes written: \(totalBytesWritten) | Total bytes: \(totalBytesExpectedToWrite)")
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        print("NSURLSession finished to url: ", location)
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath:String = path[0]
        let fileManager = FileManager()
        let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath.appendingFormat("/file.mov"))
        
        do {
            try fileManager.moveItem(at: location, to: destinationURLForFile)
            print("File moved to url: ", destinationURLForFile)
            updateSnapshot()
        } catch let err {
            print("An error occurred while moving file to destination url: \(err)")
        }
    }
    
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        print("Download completed with error: \(error)");
    }
    
}
