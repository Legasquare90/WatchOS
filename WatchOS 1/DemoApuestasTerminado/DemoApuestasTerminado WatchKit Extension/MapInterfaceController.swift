//
//  MapInterfaceController.swift
//  DemoApuestasTerminado
//
//  Created by Jose Angel Cuadrado on 19/5/15.
//  Copyright (c) 2015 IGZ. All rights reserved.
//

import WatchKit
import Foundation


class MapInterfaceController: WKInterfaceController {

    @IBOutlet weak var map: WKInterfaceMap!
    @IBOutlet weak var lblLocation: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        let location = context as! Dictionary<String, AnyObject>
        let name = location["name"] as! String
        lblLocation.setText("\(name)")
        
        let locationCoordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
        map.setRegion(MKCoordinateRegionMake(locationCoordinate, MKCoordinateSpanMake(0.02, 0.02)))
        map.addAnnotation(locationCoordinate, withPinColor: .Red)
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

}
