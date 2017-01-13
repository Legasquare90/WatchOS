//
//  HomeController.swift
//  ElMundoToday
//
//  Created by Jose Angel Cuadrado on 13/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import UserNotifications

class HomeController: WKInterfaceController {

    @IBOutlet var imageView: WKInterfaceImage!
    
    var news: [Any] = []
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("EMT")
    }
    
    override func willActivate() {
        super.willActivate()
        news = UserDefaults.standard.object(forKey: "") as! [Any]
    }
    
    override func didAppear() {
        super.didAppear()
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(500)) {
            self.animate(withDuration: 1.5) { () -> Void in
                self.imageView.setWidth(50)
                self.imageView.setHeight(50)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(2)) {
            self.animate(withDuration: 1.5) { () -> Void in
                self.imageView.setWidth(100)
                self.imageView.setHeight(100)
            }
        }
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(3000)) {
            if (self.news.count > 0) {
                let controllers = Array(repeating: "NewsController", count: 5)
                WKInterfaceController.reloadRootControllers(withNames: controllers, contexts: self.news)
            } else {
                let ok = WKAlertAction(title: "OK", style: .default) {}
                self.presentAlert(withTitle: "Actualizando...", message: "Se están descargando las noticias. Por favor, vuelve más tarde.", preferredStyle: .alert, actions: [ok])
                WKExtension.shared().scheduleBackgroundRefresh(withPreferredDate: Date(timeIntervalSinceNow: 30), userInfo: nil, scheduledCompletion: { (error:Error?) in
                    if let error = error {
                        print("Error occured while scheduling background refresh: \(error.localizedDescription)")
                    }
                })
            }
        }
    }
    
    override func handleAction(withIdentifier identifier: String?, for notification: UNNotification) {
        if (notification.request.content.categoryIdentifier == "news") {
            let userInfo = notification.request.content.userInfo
            presentController(withName: "TextBodyNewsController", context: userInfo["textBody"])
        }
    }

}
