//
//  ViewController.swift
//  DemoApuestasTerminado
//
//  Created by Jose Angel Cuadrado Mingo on 13/5/15.
//  Copyright (c) 2015 IGZ. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblMoney: UILabel!
    @IBOutlet weak var lblBets: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "setView", name: "newBet", object: nil)
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        setView()
    }

    func setView() {
        if NSUserDefaults.standardUserDefaults().objectForKey("name") != nil {
            lblName.text = NSUserDefaults.standardUserDefaults().objectForKey("name") as? String
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("money") != nil {
            let money = NSUserDefaults.standardUserDefaults().objectForKey("money") as! Int
            lblMoney.text = "\(money) €"
        }
        
        if NSUserDefaults.standardUserDefaults().objectForKey("betsPlaced") != nil {
            let betsPlaced = NSUserDefaults.standardUserDefaults().objectForKey("betsPlaced") as! [Dictionary<String, AnyObject>]
            lblBets.text = "\(betsPlaced.count)"
        }
    }

}

