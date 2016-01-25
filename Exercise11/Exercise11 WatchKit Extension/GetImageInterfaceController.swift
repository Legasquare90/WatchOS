//
//  GetImageInterfaceController.swift
//  Exercise11
//
//  Created by Jose Angel Cuadrado on 25/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class GetImageInterfaceController: WKInterfaceController {

    @IBOutlet var infoLabel: WKInterfaceLabel!
    
    var task: NSURLSessionDataTask?
    var isActive: Bool = false
    
    let userDefaults = NSUserDefaults.standardUserDefaults()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if (userDefaults.objectForKey("imageData") != nil) {
            self.infoLabel.setText("Received!")
        } else {
            
        }
    }
    
    override func willActivate() {
        super.willActivate()
        isActive = true
    }
    
    override func didDeactivate() {
        super.didDeactivate()
        isActive = false
        if let t = task {
            if t.state == NSURLSessionTaskState.Running {
                t.cancel()
            }
        }
    }
    
    @IBAction func getImageBtnTapped() {
        self.infoLabel.setText("Receiving...")
        let url = NSURL(string:"https://pbs.twimg.com/profile_images/3186881240/fa714ece16d0fabccf903cec863b1949_400x400.png")!
        let conf = NSURLSessionConfiguration.defaultSessionConfiguration()
        let session = NSURLSession(configuration: conf)
        task = session.dataTaskWithURL(url) { (data, res, error) -> Void in
            if let e = error {
                print("dataTaskWithURL fail: \(e.debugDescription)")
                return
            }
            if let d = data {
                self.userDefaults.setObject(d, forKey: "imageData")
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if self.isActive {
                        self.infoLabel.setText("Received!")
                    }
                })
            }
        }
        task!.resume()
    }

}
