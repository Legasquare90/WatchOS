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
    @IBOutlet var loadingImage: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        loadingImage.setImageNamed("Animation")
        loadingImage.setHidden(true)
    }

    override func willActivate() {
        super.willActivate()
        self.infoLabel.setText("Sin imagen")
    }

    @IBAction func getImage() {
        self.infoLabel.setText("Receiving...")
        self.loadingImage.setHidden(false)
        self.loadingImage.startAnimating()
        Alamofire.download(.GET, "https://pbs.twimg.com/media/CZOk7__WEAAXZq8.jpg") { temporaryURL, response in
            let fileManager = NSFileManager.defaultManager()
            let directoryURL = fileManager.URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask)[0]
            let pathComponent = "image.jpg"
            self.infoLabel.setText("Received!")
            self.loadingImage.setHidden(true)
            self.loadingImage.stopAnimating()
            return directoryURL.URLByAppendingPathComponent(pathComponent)
        }
    }
    
}
