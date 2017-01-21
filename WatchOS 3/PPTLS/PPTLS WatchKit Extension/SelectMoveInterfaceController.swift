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
    @IBOutlet var randomImage: WKInterfaceImage!
    
    let model = ["piedra", "papel", "tijeras", "lagarto", "spock"]
    var multiplayer = false
    var random = false
    var moveSelected = ""
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let data = context as! [String: Bool]
        multiplayer = data["multiplayer"]!
        
        multiplayer ? setTitle("Multijugador") : setTitle("Juego vs IA")
        
        var array: [WKPickerItem] = [WKPickerItem]()
        for i in 0 ..< model.count {
            let move = model[i]
            let item = WKPickerItem()
            item.contentImage = WKImage(imageName: move)
            array.append(item)
        }
        picker.setItems(array)
    }

    @IBAction func changeSwitchOption(_ value: Bool) {
        random = value
        if (random) {
            randomImage.setHidden(false)
            picker.setHidden(true)
        } else {
            randomImage.setHidden(true)
            picker.setHidden(false)
        }
    }
    
    @IBAction func pickerChangeValue(_ value: Int) {
        moveSelected = model[value]
    }
    
    @IBAction func nextAction() {
        if (random) {
            let index = Int(arc4random_uniform(UInt32(model.count)))
            moveSelected = model[index]
        }
        if (multiplayer) {
            pushController(withName: "ResultsVsPlayerInterfaceController", context: moveSelected)
        } else {
            pushController(withName: "ResultsIAInterfaceController", context: moveSelected)
        }
    }
}
