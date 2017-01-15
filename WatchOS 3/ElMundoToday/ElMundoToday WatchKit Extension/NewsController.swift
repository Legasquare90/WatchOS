//
//  NewsController.swift
//  ElMundoToday WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 2/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation

class NewsController: WKInterfaceController {
    
    @IBOutlet var newsImage: WKInterfaceImage!
    @IBOutlet var newsDateLabel: WKInterfaceLabel!
    @IBOutlet var titleLabel: WKInterfaceLabel!
    @IBOutlet var subtitleLabel: WKInterfaceLabel!
    @IBOutlet var videoButton: WKInterfaceButton!
    
    var news: [String : String] = [:]
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("EMT")
        
        news = context as! [String : String]
        
        let imageURLString = news["image"]! as String
        let imageURL = URL(string: imageURLString)
        let data = try? Data(contentsOf: imageURL!)
        newsImage.setImageData(data!)
        
        let date = news["date"]! as String
        newsDateLabel.setText(date)

        let title = news["title"]! as String
        titleLabel.setText(title)
        
        let subtitle = news["subtitle"]! as String
        subtitleLabel.setText(subtitle)
        
        if (news["video"] == nil) {
            videoButton.setHidden(true)
        }
    }

    @IBAction func readNews() {
        let text = news["text"]! as String
        presentController(withName: "TextBodyNewsController", context: text)
    }

    @IBAction func videoButtonAction() {
        let ok = WKAlertAction(title: "OK", style: .default) {}
        self.presentAlert(withTitle: "Descargando...", message: "La descarga se hará en segundo plano. Por favor, consúltelo más tarde en la sección de vídeos.", preferredStyle: .alert, actions: [ok])
        let userInfo = ["url" : news["video"]!] as NSDictionary
        WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: Date(timeIntervalSinceNow: 10), userInfo: userInfo, scheduledCompletion: { (error:Error?) in
            if let error = error {
                print("Error occured while scheduling background refresh: \(error.localizedDescription)")
            }
        })
    }

}
