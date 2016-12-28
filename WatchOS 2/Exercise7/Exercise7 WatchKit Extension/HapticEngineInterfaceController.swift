//
//  HapticEngineInterfaceController.swift
//  Exercise7
//
//  Created by Jose Angel  Cuadrado Mingo on 31/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit

class HapticEngineInterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    
    let model = ["Notification", "Up", "Down", "Success", "Failure", "Retry", "Start", "Stop", "Click"]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        setTitle("Haptic Engine")
        setupTable()
    }
    
    func setupTable() {
        tableView.setNumberOfRows(model.count, withRowType: "hapticRow")
        
        for (var i=0; i<model.count; i++) {
            let row = tableView.rowControllerAtIndex(i) as! HapticEngineRowController
            row.hapticLabel.setText(model[i])
        }
    }
    
    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        let device = WKInterfaceDevice.currentDevice()
        switch (rowIndex) {
            case 0:
                device.playHaptic(.Notification)
            case 1:
                device.playHaptic(.DirectionUp)
            case 2:
                device.playHaptic(.DirectionDown)
            case 3:
                device.playHaptic(.Success)
            case 4:
                device.playHaptic(.Failure)
            case 5:
                device.playHaptic(.Retry)
            case 6:
                device.playHaptic(.Start)
            case 7:
                device.playHaptic(.Stop)
            case 8:
                device.playHaptic(.Click)
            default:
                return
        }
    }
    
}
