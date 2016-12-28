//
//  DetailsInterfaceController.swift
//  Exercise5
//
//  Created by Jose Angel Cuadrado on 26/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class DetailsInterfaceController: WKInterfaceController {

    @IBOutlet var showImage: WKInterfaceImage!
    @IBOutlet var hourLabel: WKInterfaceLabel!
    @IBOutlet var endLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.setTitle("Estás viendo...")
        let show = context as! Dictionary<String, AnyObject>
        showImage.setImageNamed(show["img"] as? String)
        hourLabel.setText("Inicio: \(show["inicio"] as! String)")
        endLabel.setText("Fin: \(show["fin"] as! String)")
    }

}
