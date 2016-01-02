//
//  InfoDeviceInterfaceController.swift
//  Exercise7
//
//  Created by Jose Angel Cuadrado on 2/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class InfoDeviceInterfaceController: WKInterfaceController {

    @IBOutlet var systemNameLabel: WKInterfaceLabel!
    @IBOutlet var localizedModelLabel: WKInterfaceLabel!
    @IBOutlet var nameLabel: WKInterfaceLabel!
    @IBOutlet var systemVersionLabel: WKInterfaceLabel!
    @IBOutlet var scaleLabel: WKInterfaceLabel!
    @IBOutlet var preferredContentSizeCategoryLabel: WKInterfaceLabel!
    @IBOutlet var screenBoundsLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let device = WKInterfaceDevice.currentDevice()
        
        screenBoundsLabel.setText("Tamaño pantalla: \(device.screenBounds.width)x\(device.screenBounds.height)")
        scaleLabel.setText("Escala: \(device.screenScale)")
        systemVersionLabel.setText("Versión: \(device.systemVersion)")
        nameLabel.setText("Nombre: \(device.name)")
        localizedModelLabel.setText("Modelo: \(device.localizedModel)")
        systemNameLabel.setText("Sistema: \(device.systemName)")
        
        var size: String = ""
        if (device.preferredContentSizeCategory == "UICTContentSizeCategoryL") {
            size = "42mm"
        }
        if (device.preferredContentSizeCategory == "UICTContentSizeCategoryS") {
            size = "38mm"
        }
        preferredContentSizeCategoryLabel.setText("Tamaño: \(size)")

    }

}
