//
//  ImageWithAlamofireInterfaceController.swift
//  Exercise11
//
//  Created by Jose Angel Cuadrado on 26/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire

class ImageWithAlamofireInterfaceController: WKInterfaceController {

    @IBOutlet var infoLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

    @IBAction func getImage() {
        Alamofire.download(.GET, "https://pbs.twimg.com/media/CZOk7__WEAAXZq8.jpg") { temporaryURL, response in
            let fileManager = NSFileManager.defaultManager()
            let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            let pathComponent = response.suggestedFilename
            
            return directoryURL.URLByAppendingPathComponent(pathComponent!)
        }
    }
    
}
