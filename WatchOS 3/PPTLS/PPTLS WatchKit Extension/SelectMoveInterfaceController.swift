//
//  SelectMoveInterfaceController.swift
//  PPTLS
//
//  Created by Jose Angel Cuadrado on 20/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class SelectMoveInterfaceController: WKInterfaceController {

    @IBOutlet var picker: WKInterfacePicker!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
    }

    @IBAction func changeSwitchOption(_ value: Bool) {
        
    }
    
    @IBAction func pickerChangeValue(_ value: Int) {
        
    }
}
