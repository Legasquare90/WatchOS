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
        let arrayChannels = dictionary!["channels"] as! [Dictionary<String, AnyObject>]
        var channelDict = Dictionary<String, AnyObject>()
        for channel in arrayChannels {
            let channelName = channel["name"] as! String
            if (channelName == ScheduleTV().channel) {
                channelDict = channel
                channelLabel.setText(channelName)
            }
        }
        let channelShows = channelDict["schedule"] as! [Dictionary<String, AnyObject>]
        let channelImg = channelDict["logo"] as! String
        channelImage.setImageNamed(channelImg)
        for dictShow in channelShows {
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
