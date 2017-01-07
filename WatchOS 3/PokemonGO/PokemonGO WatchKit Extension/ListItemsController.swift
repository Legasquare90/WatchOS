//
//  ListItemsController.swift
//  PokemonGO
//
//  Created by Jose Angel Cuadrado on 7/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class ListItemsController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    
    var items: [Any] = []

    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Tienda")
        items = UserDefaults.standard.object(forKey: "ballTypes") as! [[String : Any]]
        setupTable()
    }

    func setupTable() {
        table.setNumberOfRows(items.count, withRowType: "RowListItems")
        for i in 0 ..< items.count {
            let row = table.rowController(at: i) as! RowListItemsController
            let item: Dictionary<String, Any> = items[i] as! Dictionary<String, Any>
            let name = item["name"] as! String
            row.nameItem.setText(name.capitalized)
            row.imageItem.setImageNamed(name)
            
//          This only works when images are located in assets folder of WhatcKit extension
//          let image = UIImage(named: name)
        }
    }
    
    override func table(_ table: WKInterfaceTable, didSelectRowAt rowIndex: Int) {
        let controllerIdentifier = "BuyItem"
        pushController(withName: controllerIdentifier, context: items[rowIndex])
    }
}

class RowListItemsController: NSObject {

    @IBOutlet var nameItem: WKInterfaceLabel!
    @IBOutlet var imageItem: WKInterfaceImage!
    
}
