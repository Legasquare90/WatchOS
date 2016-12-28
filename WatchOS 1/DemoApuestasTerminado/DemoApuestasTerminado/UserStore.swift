//
//  UserStore.swift
//  DemoApuestasTerminado
//
//  Created by Jose Angel Cuadrado on 19/5/15.
//  Copyright (c) 2015 IGZ. All rights reserved.
//

import Foundation

public class UserStore: NSObject {
   
    var name = ""
    var money = 0
    var bets = [Dictionary<String, AnyObject>]()
    
    var betsPlaced = [Dictionary<String, AnyObject>]()
    
    class var sharedInstance : UserStore {
        struct Static {
            static var oncetoken : dispatch_once_t = 0
            static var instance : UserStore? = nil
        }
        dispatch_once(&Static.oncetoken) {
            Static.instance = UserStore()
        }
        return Static.instance!
    }
    
}
