//
//  TextBodyNewsController.swift
//  ElMundoToday
//
//  Created by Jose Angel Cuadrado on 13/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation

class TextBodyNewsController: WKInterfaceController {

    @IBOutlet var body: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let text = context as! String
        body.setText(text)
    }

}
