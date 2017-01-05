//
//  CatchPokemonController.swift
//  PokemonGO
//
//  Created by Jose Angel Cuadrado on 5/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class CatchPokemonController: WKInterfaceController {

    @IBOutlet var picker: WKInterfacePicker!
    @IBOutlet var pokeballTypeLabel: WKInterfaceLabel!
    
    let model = ["Pokeball", "Superball", "Ultraball"]
    var ratio = 0.0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let pokemon = context as! Dictionary<String, Any>
        ratio = pokemon["ratio"] as! Double
        
        var array: [WKPickerItem] = [WKPickerItem]()
        for i in 0 ..< model.count {
            let pokeballType = model[i] as String
            let item = WKPickerItem()
            item.contentImage = WKImage(imageName: pokeballType.lowercased())
            array.append(item)
        }
        picker.setItems(array)
        
        pokeballTypeLabel.setText(model.first)
    }

    @IBAction func pickerChangeValue(_ value: Int) {
        pokeballTypeLabel.setText(model[value])
    }
    
    @IBAction func catchAction() {
        
    }
}
