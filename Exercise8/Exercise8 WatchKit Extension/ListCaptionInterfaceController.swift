//
//  ListCaptionInterfaceController.swift
//  Exercise8
//
//  Created by Jose Angel Cuadrado on 4/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class ListCaptionInterfaceController: WKInterfaceController {

    @IBOutlet var firstPicker: WKInterfacePicker!
    @IBOutlet var secondPicker: WKInterfacePicker!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        var array: [WKPickerItem] = [WKPickerItem]()
        for var i = 0; i < 10; i++ {
            let title = "Title \(i)"
            let item = WKPickerItem()
            item.title = title
            item.accessoryImage = WKImage(imageName: "cloud\(i)")
            item.caption = title
            array.append(item)
        }
        
        firstPicker.setItems(array)
        secondPicker.setItems(array)
    
    }

}
