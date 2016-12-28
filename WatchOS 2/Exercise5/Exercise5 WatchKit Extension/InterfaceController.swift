//
//  InterfaceController.swift
//  Exercise5 WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 20/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {

    @IBOutlet var picker: WKInterfacePicker!
    @IBOutlet var saveLabel: WKInterfaceLabel!
    
    var channelSelected = 0
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        self.setTitle("Favorito")
        
        var pickerItems : [WKPickerItem] = []
        
        let dictionary = ScheduleTV().schedule
        let arrayChannels = dictionary!["channels"] as! [Dictionary<String, AnyObject>]
        for channelDict in arrayChannels {
            let pickerItem = WKPickerItem()
            pickerItem.title = channelDict["name"] as? String
            pickerItem.caption = channelDict["name"] as? String
            pickerItems.append(pickerItem)
        }
        
        picker.setItems(pickerItems)
    }

    @IBAction func pickerSelected(value: Int) {
        channelSelected = value
    }
    
    @IBAction func saveChannel() {
        let dictionary = ScheduleTV().schedule
        let arrayChannels = dictionary!["channels"] as! [Dictionary<String, AnyObject>]
        let channel = arrayChannels[channelSelected]
        ScheduleTV().channel = channel["name"] as! String
        saveLabel.setHidden(false)
    }
    
    override func handleUserActivity(userInfo: [NSObject : AnyObject]?) {
        pushControllerWithName("details", context: userInfo!["details"])
    }

}
