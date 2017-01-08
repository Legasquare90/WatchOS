//
//  DetailPokemonController.swift
//  PokemonGO
//
//  Created by Jose Angel Cuadrado on 8/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class DetailPokemonController: WKInterfaceController {

    @IBOutlet var pokemonImage: WKInterfaceImage!
    @IBOutlet var combatPointsLabel: WKInterfaceLabel!
    @IBOutlet var healthPointsLabel: WKInterfaceLabel!
    @IBOutlet var typeImage: WKInterfaceImage!
    @IBOutlet var attackLabel: WKInterfaceLabel!
    @IBOutlet var powerAttackLabel: WKInterfaceLabel!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        pokemonImage.setImageNamed("zapdos")
    }
    
    override func willActivate() {
        super.willActivate()
        pokemonImage.startAnimatingWithImages(in: NSRange(location: 0, length: 9), duration: 1.0, repeatCount: 0)
    }

}
