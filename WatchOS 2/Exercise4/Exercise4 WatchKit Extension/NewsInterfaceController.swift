//
//  NewsInterfaceController.swift
//  Exercise4
//
//  Created by Jose Angel Cuadrado on 17/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class NewsInterfaceController: WKInterfaceController {

    @IBOutlet var newsImage: WKInterfaceImage!
    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var bodyLabel: WKInterfaceLabel!
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        
        let remoteNotification = context as! Dictionary<String, AnyObject>
        
        let aps = remoteNotification["aps"] as! Dictionary<String, AnyObject>
        
        guard let alert = aps["alert"] else {
            return
        }
        guard let title = alert["title"] else {
            return
        }
        guard let body = alert["body"] else {
            return
        }
        
        let image = remoteNotification["image"] as! String
        
        titleLabel.setText("\(title!)")
        bodyLabel.setText("\(body!)")
        newsImage.setImageNamed(image)
    
    }

}
