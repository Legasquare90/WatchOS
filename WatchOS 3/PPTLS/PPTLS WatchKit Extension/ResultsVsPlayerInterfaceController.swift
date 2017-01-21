//
//  ResultsVsPlayerInterfaceController.swift
//  PPTLS
//
//  Created by Jose Angel Cuadrado on 20/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class ResultsVsPlayerInterfaceController: WKInterfaceController, MotionManagerDelegate {

    @IBOutlet var resultImage: WKInterfaceImage!
    
    let motionManager = MotionManager()
    
    var move = ""
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Multijugador")
        move = context as! String
        motionManager.delegate = self
    }
    
    override func willActivate() {
        super.willActivate()
        motionManager.initAccelerometer()
    }
    
    func armGestureDetected() {
        resultImage.setImage(UIImage(named: move))
    }

}
