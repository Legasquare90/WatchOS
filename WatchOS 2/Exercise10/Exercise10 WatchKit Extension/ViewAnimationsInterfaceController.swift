//
//  ViewAnimationsInterfaceController.swift
//  Exercise10
//
//  Created by Jose Angel Cuadrado on 8/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class ViewAnimationsInterfaceController: WKInterfaceController {

    @IBOutlet var groupView: WKInterfaceGroup!
    @IBOutlet var imageView: WKInterfaceImage!
    
    var reverseAlpha: Bool = true
    var reverseSize: Bool = true
    var reverseInset: Bool = true
    var reverseAlignment: Bool = true
    var reverseBackground: Bool = true
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        // Configure interface objects here.
    }

    @IBAction func alphaAction() {
        animateWithDuration(0.5) { () -> Void in
            self.imageView.setAlpha(self.reverseAlpha ? 0 : 1)
            self.reverseAlpha = !self.reverseAlpha
        }
    }

    @IBAction func sizeAction() {
        animateWithDuration(0.5) { () -> Void in
            self.imageView.setWidth(self.reverseSize ? 25 : 50)
            self.imageView.setHeight(self.reverseSize ? 25 : 50)
            self.reverseSize = !self.reverseSize
        }
    }
    
    @IBAction func alignmentAction() {
        animateWithDuration(0.5) { () -> Void in
            self.imageView.setHorizontalAlignment(self.reverseAlignment ? .Left : .Center)
            self.imageView.setVerticalAlignment(self.reverseAlignment ? .Top : .Center)
            self.reverseAlignment = !self.reverseAlignment
        }
    }
    
    @IBAction func insetAction() {
        animateWithDuration(0.5) { () -> Void in
            self.groupView.setContentInset(self.reverseInset ? UIEdgeInsetsMake(40, 40, 0, 0):UIEdgeInsetsMake(0, 0, 0, 0))
            self.reverseInset = !self.reverseInset
        }
    }
    
    @IBAction func backgroundAction() {
        animateWithDuration(0.5) { () -> Void in
            self.groupView.setBackgroundColor(self.reverseBackground ? UIColor.whiteColor() : UIColor.blackColor())
            self.reverseBackground = !self.reverseBackground
        }
    }
}
