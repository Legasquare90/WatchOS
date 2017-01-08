//
//  ListPokemonController.swift
//  PokemonGO
//
//  Created by Jose Angel Cuadrado on 8/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class ListPokemonController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Listado")
    }

}

class RowListPokemonController: NSObject {
    
    @IBOutlet var pokemonImage: WKInterfaceImage!
    @IBOutlet var pokemonName: WKInterfaceLabel!
    
}
