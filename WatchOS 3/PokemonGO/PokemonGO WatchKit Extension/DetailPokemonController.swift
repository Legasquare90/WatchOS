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
    
    var pokemon: Dictionary<String, Any> = [:]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        pokemon = context as! Dictionary<String, Any>
        
        let name = pokemon["name"] as! String
        let pc = pokemon["cp"] as! Int
        let hp = pokemon["hp"] as! Int
        let power = pokemon["powerAttack"] as! Int
        
        setTitle(name.capitalized)
        pokemonImage.setImageNamed(name)
        combatPointsLabel.setText("\(pc) PC")
        healthPointsLabel.setText("\(hp) PS")
        attackLabel.setText(pokemon["attack"] as? String)
        powerAttackLabel.setText("\(power)")
        typeImage.setImageNamed(pokemon["typeAttack"] as? String)
    }
    
    @IBAction func tapImage(_ sender: Any) {
        pokemonImage.startAnimating()        
    }

}
