//
//  BuyItemController.swift
//  PokemonGO
//
//  Created by Jose Angel Cuadrado on 7/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class BuyItemController: WKInterfaceController {

    @IBOutlet var imageItem: WKInterfaceImage!
    @IBOutlet var nameItem: WKInterfaceLabel!
    
    var nameBall = ""
    var priceItem = 0
    var finalPrice = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Tienda")
        let item = context as! Dictionary<String, Any>
        
        priceItem = item["price"] as! Int
        nameBall = item["name"] as! String
        nameItem.setText("10 \(nameBall) - \(priceItem)€")
        imageItem.setImageNamed(nameBall)
    }

    @IBAction func quantitySlider(_ value: Float) {
        finalPrice = Int(value) * priceItem
        let quantity = Int(value) * 10
        nameItem.setText("\(quantity) \(nameBall) - \(finalPrice)€")
    }
    
    @IBAction func payAction() {
        
    }
}
