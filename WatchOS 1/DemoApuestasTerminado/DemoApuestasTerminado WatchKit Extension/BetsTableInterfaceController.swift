//
//  BetsTableInterfaceController.swift
//  DemoApuestasTerminado
//
//  Created by Jose Angel Cuadrado on 19/5/15.
//  Copyright (c) 2015 IGZ. All rights reserved.
//

import WatchKit
import Foundation


class BetsTableInterfaceController: WKInterfaceController {

    @IBOutlet weak var tableBets: WKInterfaceTable!
    
    var arrayBets = Array<Dictionary<String, AnyObject>>()
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        setTitle("Today bets")
        arrayBets = UserStore.sharedInstance.bets
        setupTable()
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }
    
    func setupTable() {
        tableBets.setNumberOfRows(arrayBets.count, withRowType: "betRow")
        for(var i:Int = 0; i<arrayBets.count; i++) {
            let row = tableBets.rowControllerAtIndex(i) as! BetRowController
            row.lblLocal.setText(arrayBets[i]["local"] as? String)
            row.lblVisitant.setText(arrayBets[i]["visitant"] as? String)
            row.dateBet.setText(arrayBets[i]["hour"] as? String)
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        pushControllerWithName("bet", context: arrayBets[rowIndex])
    }

}
