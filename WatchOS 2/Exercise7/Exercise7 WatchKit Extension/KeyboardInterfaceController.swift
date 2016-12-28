//
//  KeyboardInterfaceController.swift
//  Exercise7
//
//  Created by Jose Angel Cuadrado on 3/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class KeyboardInterfaceController: WKInterfaceController {

    @IBOutlet var answerLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        setTitle("Keyboard")
    }
    
    @IBAction func answerButtonAction() {
        presentTextInputControllerWithSuggestions(["¡Hola!", "Adiós", "¿Quién eres?"], allowedInputMode: .AllowEmoji) { (results: [AnyObject]?) -> Void in
            let textResponse = results!.first! as! String
            self.answerLabel.setText("Tú: \(textResponse)")
            self.answerLabel.setHidden(false)
        }
    }

}
