//
//  PickerAnimationInterfaceController.swift
//  Exercise8
//
//  Created by Jose Angel Cuadrado on 4/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class PickerAnimationInterfaceController: WKInterfaceController {

    @IBOutlet var picker: WKInterfacePicker!
    @IBOutlet var group: WKInterfaceGroup!
    @IBOutlet var secondGroup: WKInterfaceGroup!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        var array: [WKPickerItem] = [WKPickerItem]()
        for var i = 0; i < 119; i++ {
            let image = "activity-\(i)"
            let item = WKPickerItem()
            item.contentImage = WKImage(imageName: image)
            array.append(item)
        }
        
        picker.setItems(array)
    
    }

    @IBAction func pickerChangesValue(value: Int) {
        print(value)
        group.setBackgroundImageNamed("activity-\(value)")
        secondGroup.setBackgroundImageNamed("activity-\(value)")
    }
}
