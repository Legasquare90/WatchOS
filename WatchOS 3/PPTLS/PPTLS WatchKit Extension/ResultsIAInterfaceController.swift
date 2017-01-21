//
//  ResultsIAInterfaceController.swift
//  PPTLS
//
//  Created by Jose Angel Cuadrado on 20/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class ResultsIAInterfaceController: WKInterfaceController {

    @IBOutlet var infoLabel: WKInterfaceLabel!
    @IBOutlet var ownMoveImage: WKInterfaceImage!
    @IBOutlet var iaMoveImage: WKInterfaceImage!
    @IBOutlet var exitButton: WKInterfaceButton!
    
    var move = ""

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Juego vs IA")
        move = context as! String
    }

    @IBAction func exitAction() {
        popToRootController()
    }
}
