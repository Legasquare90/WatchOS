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
    @IBOutlet var catchButton: WKInterfaceButton!
    
    var model: [Any] = []
    var namePokemon = ""
    var ballType = ""
    var ratioPokemon = 0.0
    var ratioBall = 0.0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        let pokemon = context as! Dictionary<String, Any>
        namePokemon = pokemon["name"] as! String
        ratioPokemon = pokemon["ratio"] as! Double
        
        setTitle(namePokemon)
        
        model = UserDefaults.standard.object(forKey: "ballTypes") as! [[String : Any]]
        
        var array: [WKPickerItem] = [WKPickerItem]()
        for i in 0 ..< model.count {
            let pokeballType = model[i] as! [String : Any]
            let item = WKPickerItem()
            item.contentImage = WKImage(imageName: pokeballType["name"] as! String)
            array.append(item)
        }
        picker.setItems(array)
        
        let firstBall = model.first as! [String : Any]
        let name = firstBall["name"] as! String
        ballType = name.capitalized
        pokeballTypeLabel.setText(ballType)
        ratioBall = firstBall["ratio"] as! Double
    }

    @IBAction func pickerChangeValue(_ value: Int) {
        let ball = model[value] as! [String : Any]
        let name = ball["name"] as! String
        ballType = name.capitalized
        pokeballTypeLabel.setText(ballType)
        ratioBall = ball["ratio"] as! Double
    }
    
    @IBAction func catchAction() {
        catchButton.setEnabled(false)
        let random : Double = drand48()
        let caught = (random * ratioBall) >= ratioPokemon
        print("Pokemon ratio: \(ratioPokemon) | Capture ratio: \(random * ratioBall)")
        var text = "1... "
        pokeballTypeLabel.setText(text)
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(1)) {
            text += "2... "
            self.pokeballTypeLabel.setText(text)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            text += "3..."
            self.pokeballTypeLabel.setText(text)
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3)) {
            self.catchButton.setEnabled(true)
            if (caught) {
                let ok = WKAlertAction(title: "OK", style: .default, handler: {
                    self.popToRootController()
                })
                self.presentAlert(withTitle: "¡Éxito!", message: "Has atrapado a \(self.namePokemon)", preferredStyle: .alert, actions: [ok])
            } else {
                let retry = WKAlertAction(title: "Reintentar", style: .default) {
                    self.pokeballTypeLabel.setText(self.ballType)
                }
                self.presentAlert(withTitle: "¡Ha escapado!", message: "¡Casi lo atrapas!", preferredStyle: .alert, actions: [retry])
            }
        }
    }
}
