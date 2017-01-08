//
//  BuyItemController.swift
//  PokemonGO
//
//  Created by Jose Angel Cuadrado on 7/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import PassKit

class BuyItemController: WKInterfaceController {

    @IBOutlet var imageItem: WKInterfaceImage!
    @IBOutlet var nameItem: WKInterfaceLabel!
    
    let paymentHandler = PaymentHandler()

    var nameBall = ""
    var priceItem = 0
    var finalPrice = 0
    var quantity = 0
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Tienda")
        let item = context as! Dictionary<String, Any>
        
        quantity = 10
        priceItem = item["price"] as! Int
        finalPrice = priceItem
        nameBall = item["name"] as! String
        nameItem.setText("\(quantity) \(nameBall) - \(priceItem)€")
        imageItem.setImageNamed(nameBall)
    }

    @IBAction func quantitySlider(_ value: Float) {
        finalPrice = Int(value) * priceItem
        quantity = Int(value) * 10
        nameItem.setText("\(quantity) \(nameBall) - \(finalPrice)€")
    }
    
    @IBAction func payAction() {
        paymentHandler.startPayment(item: nameBall, quantity: quantity, price: Double(finalPrice)) { (success) in
            if success {
                let retry = WKAlertAction(title: "OK", style: .default) {
                    self.popToRootController()
                }
                self.presentAlert(withTitle: "Compra realizada", message: "Has comprado \(self.quantity) \(self.nameBall), ¡sigamos cazando!", preferredStyle: .alert, actions: [retry])
            } else {
                let retry = WKAlertAction(title: "OK", style: .default) {}
                self.presentAlert(withTitle: "Error", message: "Se ha producido un error en el pago", preferredStyle: .alert, actions: [retry])
            }
        }
    }
}
