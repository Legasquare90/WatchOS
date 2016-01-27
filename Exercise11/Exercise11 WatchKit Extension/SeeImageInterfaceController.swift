//
//  SeeImageInterfaceController.swift
//  Exercise11
//
//  Created by Jose Angel Cuadrado on 26/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class SeeImageInterfaceController: WKInterfaceController {

    @IBOutlet var image: WKInterfaceImage!
    @IBOutlet var imageFileManager: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // NSUserDefaults
        if let imageData = NSUserDefaults.standardUserDefaults().objectForKey("imageData") {
            self.image.setImageData(imageData as? NSData)
        }
        
        // NSFileManager
        let fileManager = NSFileManager.defaultManager()
        let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
        let imageURL = directoryURL.URLByAppendingPathComponent("image.jpg")
        let imageDataFileManager = NSData(contentsOfURL: imageURL)
        self.imageFileManager.setImageData(imageDataFileManager!)
    }

}
