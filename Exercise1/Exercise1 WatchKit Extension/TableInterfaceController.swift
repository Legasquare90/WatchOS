//
//  TableInterfaceController.swift
//  Exercise1
//
//  Created by Jose Angel Cuadrado on 7/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class TableInterfaceController: WKInterfaceController {

    @IBOutlet var table: WKInterfaceTable!
    
    let model = [0:"Formato", 1:"Timer"]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        setTitle("Opciones")
        setupTable()
    }
    
    func setupTable() {
        table.setNumberOfRows(model.count, withRowType: "rowTable")
        
        for(var i:Int = 0; i<model.count; i++) {
            let row = table.rowControllerAtIndex(i) as! RowController
            row.textLabel.setText(model[i])
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        let controllerIdentifier: String = model[rowIndex]!
        pushControllerWithName(controllerIdentifier, context: nil)
    }

}
