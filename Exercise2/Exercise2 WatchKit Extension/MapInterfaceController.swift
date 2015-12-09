//
//  MapInterfaceController.swift
//  Exercise2 WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 8/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class MapInterfaceController: WKInterfaceController {

    @IBOutlet var lblPlace: WKInterfaceLabel!
    @IBOutlet var map: WKInterfaceMap!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        if (context == nil) {
            let objects = [["name":"UPSA", "latitude":40.962009, "longitude":-5.665677], ["name":"IGZ", "latitude":40.421322, "longitude":-3.705472], ["name":"T3chFest (UC3M)", "latitude":40.332143, "longitude":-3.835696]]
            let controllers = Array(count: objects.count, repeatedValue: "map")
            WKInterfaceController.reloadRootControllersWithNames( controllers, contexts: objects )
        } else {
            let location = context as! Dictionary<String, AnyObject>
            let name = location["name"] as! String
            lblPlace.setText("\(name)")
            
            let locationCoordinate = CLLocationCoordinate2D(latitude: location["latitude"] as! CLLocationDegrees, longitude: location["longitude"] as! CLLocationDegrees)
            map.setRegion(MKCoordinateRegionMake(locationCoordinate, MKCoordinateSpanMake(0.02, 0.02)))
            map.addAnnotation(locationCoordinate, withPinColor: .Red)
        }
    }

}
