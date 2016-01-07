//
//  TransferFileInterfaceController.swift
//  Exercise9
//
//  Created by Jose Angel Cuadrado on 7/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class TransferFileInterfaceController: WKInterfaceController {

    @IBOutlet var image: WKInterfaceImage!
    @IBOutlet var errorLabel: WKInterfaceLabel!
    @IBOutlet var updateButton: WKInterfaceButton!
        
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }
    
    override func willActivate() {
        super.willActivate()
        setView()
    }

    @IBAction func updateButtonAction() {
        setView()
    }
    
    func setView() {
        let imageData : NSData? = NSUserDefaults.standardUserDefaults().objectForKey("item") as? NSData
        if (imageData != nil) {
            self.updateButton.setHidden(true)
            self.errorLabel.setHidden(true)
            self.image.setHidden(false)
            self.image.setImage(UIImage(data: imageData!))
        } else {
            self.updateButton.setHidden(false)
            self.errorLabel.setHidden(false)
            self.image.setHidden(true)
        }
    }
}
