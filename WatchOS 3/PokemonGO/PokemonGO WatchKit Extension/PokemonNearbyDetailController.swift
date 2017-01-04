//
//  PokemonNearbyDetailController.swift
//  PokemonGO
//
//  Created by Jose Angel Cuadrado on 4/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class PokemonNearbyDetailController: WKInterfaceController {

    enum NearbyType: Int {
        case veryNear = 1,
             near = 2,
             far = 3
    }
    
    @IBOutlet var map: WKInterfaceMap!
    @IBOutlet var distanceLabel: WKInterfaceLabel!
    @IBOutlet var catchButton: WKInterfaceButton!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        let pokemon = context as! Dictionary<String, Any>
        setTitle(pokemon["name"] as? String)
        switch pokemon["nearbyType"] as! Int {
            case NearbyType.veryNear.rawValue:
                distanceLabel.setText("¡Muy cerca!")
                catchButton.setEnabled(true)
                break
            case NearbyType.near.rawValue:
                distanceLabel.setText("Cerca")
                catchButton.setEnabled(false)
                break
            case NearbyType.far.rawValue:
                distanceLabel.setText("Lejos")
                catchButton.setEnabled(false)
                break
            default:
                break;
        }
        let locationCoordinate = CLLocationCoordinate2DMake(pokemon["latitude"] as! CLLocationDegrees, pokemon["longitude"] as! CLLocationDegrees)
        map.setRegion(MKCoordinateRegionMake(locationCoordinate, MKCoordinateSpanMake(0.02, 0.02)))
        map.addAnnotation(locationCoordinate, with: .red)
    }
    
    @IBAction func catchAction() {
        
    }
}
