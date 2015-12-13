//
//  PickerTeamInterfaceController.swift
//  Exercise3
//
//  Created by Jose Angel Cuadrado on 13/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class PickerTeamInterfaceController: WKInterfaceController {

    @IBOutlet var picker: WKInterfacePicker!
    @IBOutlet var pickerItemSelectedLabel: WKInterfaceLabel!
    
    var teams = ["R. Madrid", "Barcelona", "Valencia", "Ath. Bilbao", "Sevilla"]
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        pickerItemSelectedLabel.setText("Equipo: \(teams[0])")
        
        var items: [WKPickerItem] = [WKPickerItem]()

        for team in teams {
            let item = WKPickerItem()
            item.title = team
            items.append(item)
        }
        
        picker.setItems(items)
        
    }

    @IBAction func pickerAction(value: Int) {
        pickerItemSelectedLabel.setText("Equipo: \(teams[value])")
    }
}
