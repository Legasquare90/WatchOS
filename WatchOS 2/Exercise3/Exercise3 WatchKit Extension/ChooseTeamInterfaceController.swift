//
//  ChooseTeamInterfaceController.swift
//  Exercise3 WatchKit Extension
//
//  Created by Jose Angel Cuadrado Mingo on 9/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class ChooseTeamInterfaceController: WKInterfaceController {

    @IBOutlet var teamCounterLabel: WKInterfaceLabel!
    @IBOutlet var slider: WKInterfaceSlider!
    
    var teamCounter: Int? = 2
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
    }

    @IBAction func sliderAction(value: Float) {
        self.teamCounter = Int(value)
        self.teamCounterLabel.setText("Nº Equipos: \(self.teamCounter!)")
    }
    
    @IBAction func chooseButton() {
        let controllers = Array(count: self.teamCounter!, repeatedValue: "pickerTeam")
        presentControllerWithNames(controllers, contexts: nil)
    }
    
    @IBAction func videoMenuAction() {
        // Válido sólo con navegación jerárquica
        pushControllerWithName("video", context: nil)
        
        /*
        // Alternativa
        let url = NSBundle.mainBundle().URLForResource("movieclip", withExtension: "mov")
        let options = [WKMediaPlayerControllerOptionsAutoplayKey : "false"]
        presentMediaPlayerControllerWithURL(url!, options: options) { (didPlayToEnd, endTime, error) -> Void in
            
        }
        */
    }
}
