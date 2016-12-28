//
//  StackInterfaceController.swift
//  Exercise8
//
//  Created by Jose Angel Cuadrado on 4/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class StackInterfaceController: WKInterfaceController {

    @IBOutlet var picker: WKInterfacePicker!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        var array: [WKPickerItem] = [WKPickerItem]()
        for var i = 0; i < 11; i++ {
            let image = "cloud\(i)"
            let item = WKPickerItem()
            item.contentImage = WKImage(imageName: image)
            array.append(item)
        }
        
        picker.setItems(array)
    
    }

}
