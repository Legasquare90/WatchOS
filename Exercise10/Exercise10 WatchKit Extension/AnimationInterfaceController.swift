//
//  AnimationInterfaceController.swift
//  Exercise10
//
//  Created by Jose Angel Cuadrado on 8/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class AnimationInterfaceController: WKInterfaceController {

    @IBOutlet var image: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        image.setImageNamed("Animation")
    }

    @IBAction func startAction() {
        image.startAnimating()
    }
    
    @IBAction func stopAction() {
        image.stopAnimating()
    }
}
