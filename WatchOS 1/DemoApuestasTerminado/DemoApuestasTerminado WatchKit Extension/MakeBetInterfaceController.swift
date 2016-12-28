//
//  MakeBetInterfaceController.swift
//  DemoApuestasTerminado
//
//  Created by Jose Angel Cuadrado on 19/5/15.
//  Copyright (c) 2015 IGZ. All rights reserved.
//

import WatchKit
import Foundation


class MakeBetInterfaceController: WKInterfaceController {

    @IBOutlet weak var switchWinner: WKInterfaceSwitch!
    @IBOutlet weak var lblMoney: WKInterfaceLabel!
    @IBOutlet weak var lblBet: WKInterfaceLabel!
    @IBOutlet weak var btnConfirm: WKInterfaceButton!
    @IBOutlet weak var separator1: WKInterfaceSeparator!
    @IBOutlet weak var separator2: WKInterfaceSeparator!
    
    var game = Dictionary<String, AnyObject>()
    var valueSliderMoney = 0
    var winner = ""
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        game = context as! Dictionary<String, AnyObject>
        setTitle("Bet")
        
        var local = game["local"] as! String
        winner = local
        switchWinner.setTitle("¿Gana \(local)?")
        
        setInterface()
    }

    override func willActivate() {
        super.willActivate()
    }

    override func didDeactivate() {
        super.didDeactivate()
    }

    func setInterface() {
        lblMoney.setText("\(valueSliderMoney) €")
        if (valueSliderMoney != 0) {
            lblBet.setHidden(false)
            separator1.setHidden(false)
            separator2.setHidden(false)
            if (valueSliderMoney > UserStore.sharedInstance.money) {
                lblBet.setText("La apuesta no puede exceder su saldo")
                btnConfirm.setEnabled(false)
            } else {
                lblBet.setText("Apuestas \(valueSliderMoney) € a favor de \(winner)")
                btnConfirm.setEnabled(true)
            }
        } else {
            lblBet.setHidden(true)
            separator1.setHidden(true)
            separator2.setHidden(true)
            btnConfirm.setEnabled(false)
        }
    }
    
    @IBAction func btnConfirmAction() {
        UserStore.sharedInstance.betsPlaced.append(["win":winner, "bet":valueSliderMoney])
        UserStore.sharedInstance.money -= valueSliderMoney
        MakeBetInterfaceController.openParentApplication(["task":"newBet", "betsPlaced":UserStore.sharedInstance.betsPlaced, "money":UserStore.sharedInstance.money], reply: nil)
        popToRootController()
    }
    
    @IBAction func changeValueSliderMoney(value: Float) {
        valueSliderMoney = Int(value)
        setInterface()
    }
    
    @IBAction func changeValueSwitchWinner(value: Bool) {
        if (value) {
            winner = game["local"] as! String
        } else {
            winner = game["visitant"] as! String
        }
        setInterface()
    }
}
