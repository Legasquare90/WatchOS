//
//  ImageInterfaceController.swift
//  Exercise10
//
//  Created by Jose Angel Cuadrado on 11/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class ImageInterfaceController: WKInterfaceController {

    @IBOutlet var image: WKInterfaceImage!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        let theImage = UIImage(named: "manzana")
        image.setImage(theImage!)
    }

}
