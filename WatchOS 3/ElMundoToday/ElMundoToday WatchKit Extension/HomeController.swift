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

    enum NewsError: Error {
        case parseError
    }
    
    @IBOutlet var imageView: WKInterfaceImage!
    @IBOutlet var titleLabel: WKInterfaceLabel!
    
    var news: [[String : String]] = []
    var scheduledTask = false
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("EMT")
    }
    
    override func willActivate() {
        super.willActivate()
        downloadNews()
        
        let path = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentDirectoryPath:String = path[0]
        let fileManager = FileManager()
        let destinationURLForFile = URL(fileURLWithPath: documentDirectoryPath.appendingFormat("/file.mov"))

        if fileManager.fileExists(atPath: destinationURLForFile.absoluteString) {
            titleLabel.setText("¡Encontrado!")
        } else {
            titleLabel.setText(":(")

        }
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
            self.titleLabel.setHidden(false)
        }
    }
    
    override func handleAction(withIdentifier identifier: String?, for notification: UNNotification) {
        if (notification.request.content.categoryIdentifier == "news") {
            let userInfo = notification.request.content.userInfo
            presentController(withName: "TextBodyNewsController", context: userInfo["textBody"])
        }
    }
    
    func downloadNews() {
        let url = URL(string: "http://private-66576-elmundotodayupsa.apiary-mock.com/news")
        var urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = "GET"
        let conf = URLSessionConfiguration.default
        let session = URLSession(configuration: conf)
        let task: URLSessionDataTask = session.dataTask(with: urlRequest) { (dataResponse, urlResponse, errorResponse) in
            guard errorResponse == nil else {
                print("dataTask fail: \(errorResponse!.localizedDescription)")
                return
            }
            guard let data = dataResponse else {
                print("dataTask fail: not received data")
                return
            }
            do {
                guard let listNews = try JSONSerialization.jsonObject(with: data, options: []) as? [[String : String]] else {
                    throw NewsError.parseError
                }
                self.news = listNews
                self.navigateToNews()
                print(listNews)
            } catch {
                print("dataTask fail: error parsing JSON")
                return
            }
        }
        task.resume()
    }
    
    func navigateToNews() {
        let controllers = Array(repeating: "NewsController", count: self.news.count)
        WKInterfaceController.reloadRootControllers(withNames: controllers, contexts: self.news)
    }

}
