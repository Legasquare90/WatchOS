//
//  ListSimpleInterfaceController.swift
//  Exercise8
//
//  Created by Jose Angel Cuadrado on 4/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class ListSimpleInterfaceController: WKInterfaceController {

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
            array.append(item)
        }
        
        firstPicker.setItems(array)
        secondPicker.setItems(array)
        
    }
    
    override func pickerDidFocus(picker: WKInterfacePicker) {
        print("\(picker.debugDescription) tiene el foco");
    }
    
    override func pickerDidResignFocus(picker: WKInterfacePicker) {
        print("\(picker.debugDescription) pierde el foco");
    }

    @IBAction func firstPickerChangeValue(value: Int) {
        print("El valor del picker1 es: \(value)")
    }
    
    @IBAction func secondPickerChangeValue(value: Int) {
        print("El valor del picker2 es: \(value)")
    }
}
