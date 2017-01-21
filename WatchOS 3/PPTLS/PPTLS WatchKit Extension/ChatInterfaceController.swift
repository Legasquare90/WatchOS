//
//  ChatInterfaceController.swift
//  PPTLS
//
//  Created by Jose Angel Cuadrado on 21/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class ChatInterfaceController: WKInterfaceController {

    @IBOutlet var groupAnswer: WKInterfaceGroup!
    @IBOutlet var answerLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Chat")
    }

    @IBAction func answerAction() {
        presentTextInputController(withSuggestions: ["Si", "No"], allowedInputMode: .allowEmoji) { (results) in
            if (results != nil) {
                let textResponse = results!.first! as! String
                self.answerLabel.setText(textResponse)
                self.groupAnswer.setHidden(false)
            }
        }
    }
}
