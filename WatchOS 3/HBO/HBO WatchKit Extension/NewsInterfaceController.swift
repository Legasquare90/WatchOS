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
        }
    }

}
