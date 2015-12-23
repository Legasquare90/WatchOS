//
//  GlanceController.swift
//  Exercise5 WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 20/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class GlanceController: WKInterfaceController {

    @IBOutlet var channelImage: WKInterfaceImage!
    @IBOutlet var channelLabel: WKInterfaceLabel!
    @IBOutlet var tvShowImage: WKInterfaceImage!
    @IBOutlet var tvShowLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        let dictionary = ScheduleTV().schedule
        let arrayShows = dictionary!["Discovery Max"] as! [Dictionary<String, AnyObject>]
        channelImage.setImageNamed("discovery_max")
        channelLabel.setText("Discovery Max")
        for dictShow in arrayShows {
            let horaInicioCompleto = dictShow["inicio"] as! String
            let horaInicio = Int(horaInicioCompleto.characters.split(":").map(String.init)[0])
            let horaFinCompleto = dictShow["fin"] as! String
            let horaFin = Int(horaFinCompleto.characters.split(":").map(String.init)[0])

            let date = NSDate()
            let calendar = NSCalendar.currentCalendar()
            let components = calendar.components(NSCalendarUnit.Hour.union(NSCalendarUnit.Minute), fromDate: date)
            let hour = components.hour
            
            if (hour >= horaInicio && hour <= horaFin) {
                tvShowImage.setImageNamed(dictShow["img"] as? String)
                tvShowLabel.setText(dictShow["name"] as? String)
            }
        }
    }

    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }

}
