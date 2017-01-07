//
//  PokemonNearbyController.swift
//  PokemonGO WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 3/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation

class PokemonNearbyController: WKInterfaceController {
    
    enum PokemonNearbyError: Error {
        case parseError
    }
    
    @IBOutlet var table: WKInterfaceTable!
    @IBOutlet var loadingLabel: WKInterfaceLabel!

    var pokemonNearby: [Dictionary<String, Any>] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Pokemon GO")
        table.setHidden(true)
        loadingLabel.setHidden(false)
        getNearbyPokemon()
    }
    
    func setupTable() {
        table.setNumberOfRows(pokemonNearby.count, withRowType: "rowPokemonNearby")
        for i in 0 ..< pokemonNearby.count {
            let row = table.rowController(at: i) as! RowPokemonNearbyController
            let pokemon: Dictionary<String, Any> = pokemonNearby[i]
            row.namePokemonNearby.setText(pokemon["name"] as? String)
            let urlImage = URL(string: (pokemon["image"] as? String)!)
            let data = try? Data(contentsOf: urlImage!)
            let image = UIImage(data: data!)
            row.imagePokemonNearby.setImage(image)
        }
        table.setHidden(false)
        loadingLabel.setHidden(true)
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let controllerIdentifier = "PokemonNearbyDetail"
        pushController(withName: controllerIdentifier, context: pokemonNearby[rowIndex])
    }
    
    @IBAction func shopMenuAction() {
        let controllerIdentifier = "ListItems"
        pushController(withName: controllerIdentifier, context: nil)
    }
    
    func getNearbyPokemon() {
        let url = URL(string: "http://private-64c57c-pokemongoupsa.apiary-mock.com/nearby")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        let conf = URLSessionConfiguration.default
        let session = URLSession(configuration: conf)
        let task: URLSessionDataTask = session.dataTask(with: urlRequest) { (dataResponse, urlResponse, errorResponse) in
            guard errorResponse == nil else {
                print("dataTask fail: \(errorResponse!.localizedDescription)")
                return
            }
            guard let data = dataResponse else {
                print("dataTask fail: not received data")
                return
            }
            do {
                guard let pokemonNearby = try JSONSerialization.jsonObject(with: data, options: []) as? [Dictionary<String, Any>] else {
                    throw PokemonNearbyError.parseError
                }
                self.pokemonNearby = pokemonNearby
                self.setupTable()
                print(pokemonNearby)
            } catch {
                print("dataTask fail: error parsing JSON")
                return
            }
        }
        task.resume()
    }
}

class RowPokemonNearbyController: NSObject {
    
    @IBOutlet var imagePokemonNearby: WKInterfaceImage!
    @IBOutlet var namePokemonNearby: WKInterfaceLabel!
    
}
