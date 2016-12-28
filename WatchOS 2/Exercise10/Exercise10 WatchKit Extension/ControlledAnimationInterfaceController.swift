//
//  ControlledAnimationInterfaceController.swift
//  Exercise10
//
//  Created by Jose Angel Cuadrado on 8/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class ControlledAnimationInterfaceController: WKInterfaceController {

    @IBOutlet var image: WKInterfaceImage!
    @IBOutlet var speedLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        image.setImageNamed("Animation")
        image.startAnimatingWithImagesInRange(NSRange(location: 0, length: 9), duration: 0.4, repeatCount: 0)
    }

    @IBAction func sliderChangeValue(value: Float) {
        let valueString = String(format: "%.1f", value)
        speedLabel.setText("Vel: \(valueString)")
        image.startAnimatingWithImagesInRange(NSRange(location: 0, length: 9), duration: Double(value), repeatCount: 0)
    }
}
