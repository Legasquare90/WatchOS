//
//  InterfaceController.swift
//  Exercise7 WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 29/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    
    let model = ["Accelerometer", "DeviceMotion", "HapticEngine"]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        setupTable()
    }

    func setupTable() {
        tableView.setNumberOfRows(model.count, withRowType: "row")
        
        for (var i=0; i<model.count; i++) {
            let row = tableView.rowControllerAtIndex(i) as! RowController
            row.nameLabel.setText(model[i])
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        pushControllerWithName(model[rowIndex], context: nil)
    }

}
