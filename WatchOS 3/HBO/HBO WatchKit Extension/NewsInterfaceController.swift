//
//  NewsInterfaceController.swift
//  HBO WatchKit Extension
//
//  Created by Jose Angel Cuadrado on 17/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation
import Alamofire

class NewsInterfaceController: WKInterfaceController {

    enum NewsType: Int {
        case bigNews = 1, smallNews = 2
    }
    
    var news: [[String: Any]] = []
    
    @IBOutlet var table: WKInterfaceTable!
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Noticias")
        
        Alamofire.request(URL(string: "http://private-a6537-hboupsa.apiary-mock.com/news")!, method: .get, parameters: nil).responseJSON { (dataResponse) in
            guard dataResponse.result.isSuccess else {
                print("Error while fetching news: \(dataResponse.result.error)")
                return
            }
            
            guard let newsList = dataResponse.result.value as? [[String: Any]] else {
                print("Malformed data received")
                return
            }
            
            print(newsList)
            self.news = newsList
            self.setupTable()
        }
    }
    
    func setupTable() {
        let countBigNews = news.filter { (newsItem) -> Bool in
            let type = newsItem["newsType"] as! Int
            return type == NewsType.bigNews.rawValue
        }.count
        var rowTypes = Array(repeating: "RowBigNews", count: countBigNews)
        rowTypes += Array(repeating: "RowSmallNews", count: news.count - countBigNews)
        table.setRowTypes(rowTypes)
        for i in 0 ..< news.count {
            let newsItem = news[i] as [String: Any]
            if ((newsItem["newsType"] as! Int) == NewsType.bigNews.rawValue) {
                let row = table.rowController(at: i) as! RowBigNewsController
                let title = newsItem["title"] as! String
                row.newsTitle.setText(title)
                let urlImage = URL(string: (newsItem["image"] as? String)!)
                let data = try? Data(contentsOf: urlImage!)
                let image = UIImage(data: data!)
                row.newsImage.setImage(image)
            } else {
                let row = table.rowController(at: i) as! RowSmallNewsController
                let title = newsItem["title"] as! String
                row.newsTitle.setText(title)
                let urlImage = URL(string: (newsItem["image"] as? String)!)
                let data = try? Data(contentsOf: urlImage!)
                let image = UIImage(data: data!)
                row.newsImage.setImage(image)
            }
        }
    }

}

class RowBigNewsController: NSObject {
    
    @IBOutlet var newsImage: WKInterfaceImage!
    @IBOutlet var newsTitle: WKInterfaceLabel!
    
}

class RowSmallNewsController: NSObject {
    
    @IBOutlet var newsImage: WKInterfaceImage!
    @IBOutlet var newsTitle: WKInterfaceLabel!

}
