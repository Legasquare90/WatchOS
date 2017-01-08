//
//  ListPokemonController.swift
//  PokemonGO
//
//  Created by Jose Angel Cuadrado on 8/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import WatchConnectivity

class ListPokemonController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    @IBOutlet var loadingLabel: WKInterfaceLabel!
    
    var listPokemon: [[String: Any]] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Listado")
        
        loadingLabel.setHidden(false)
        table.setHidden(true)
        
        let actionWC = ["action" : "listPokemon"]
        
        let session = WCSession.default()
        if (session.isReachable) {
            session.sendMessage(actionWC, replyHandler: { (replyData) in
                print("Reply data received")
                self.listPokemon = replyData["listPokemon"] as! [[String : Any]]
                self.setupTable()
            }, errorHandler: { (error) in
                print(error.localizedDescription)
            })
        }
    }
    
    func setupTable() {
        table.setNumberOfRows(listPokemon.count, withRowType: "RowListPokemon")
        for i in 0 ..< listPokemon.count {
            let row = table.rowController(at: i) as! RowListPokemonController
            let pokemon: Dictionary<String, Any> = listPokemon[i] 
            let name = pokemon["name"] as! String
            row.pokemonName.setText(name.capitalized)
            row.pokemonImage.setImageNamed("\(name)0")
        }
        loadingLabel.setHidden(true)
        table.setHidden(false)
    }
    
    override func contextForSegue(withIdentifier segueIdentifier: String, in table: WKInterfaceTable, rowIndex: Int) -> Any? {
        if (segueIdentifier == "detailPokemonSegue") {
            return listPokemon[rowIndex]
        } else {
            return nil;
        }
    }

}

class RowListPokemonController: NSObject {
    
    @IBOutlet var pokemonImage: WKInterfaceImage!
    @IBOutlet var pokemonName: WKInterfaceLabel!
    
}
