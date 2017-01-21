//
//  MenuInterfaceController.swift
//  PPTLS
//
//  Created by Jose Angel Cuadrado on 20/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class MenuInterfaceController: WKInterfaceController {

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("PPTLS")
    }

    @IBAction func playVsIAAction() {
        pushController(withName: "SelectMoveInterfaceController", context: ["multiplayer":false])
    }

    @IBAction func playVsOthersAction() {
        pushController(withName: "SelectMoveInterfaceController", context: ["multiplayer":true])
    }

    @IBAction func chatAction() {
    }
}
