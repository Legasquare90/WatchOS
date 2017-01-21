//
//  ResultsIAInterfaceController.swift
//  PPTLS
//
//  Created by Jose Angel Cuadrado on 20/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class ResultsIAInterfaceController: WKInterfaceController, MotionManagerDelegate {

    enum Moves: String {
        case piedra = "piedra", papel = "papel", tijeras = "tijeras", lagarto = "lagarto", spock = "spock"
    }
    
    @IBOutlet var infoLabel: WKInterfaceLabel!
    @IBOutlet var ownMoveImage: WKInterfaceImage!
    @IBOutlet var iaMoveImage: WKInterfaceImage!
    @IBOutlet var exitButton: WKInterfaceButton!
    
    let motionManager = MotionManager()
    let model = ["piedra", "papel", "tijeras", "lagarto", "spock"]

    var movePlayer = ""
    var gameOver = false
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Juego vs IA")
        movePlayer = context as! String
        motionManager.delegate = self
    }

    override func willActivate() {
        super.willActivate()
        if (!gameOver) {
            motionManager.initAccelerometer()
        }
    }
    
    @IBAction func exitAction() {
        popToRootController()
    }
    
    func armGestureDetected() {
        exitButton.setHidden(false)
        ownMoveImage.setImageNamed(movePlayer)
        
        var iaMove = ""
        repeat {
            let index = Int(arc4random_uniform(UInt32(model.count)))
            iaMove = model[index]
        } while (iaMove == movePlayer)
        
        iaMoveImage.setImageNamed(iaMove)
        
        winnerIAMove(iaMove: iaMove)
    }
    
    func winnerIAMove(iaMove: String) {
        var winnerIA = false

        switch iaMove {
        case Moves.piedra.rawValue:
            if (movePlayer == Moves.tijeras.rawValue || movePlayer == Moves.lagarto.rawValue) {
                winnerIA = true
            }
            break
        case Moves.papel.rawValue:
            if (movePlayer == Moves.piedra.rawValue || movePlayer == Moves.spock.rawValue) {
                winnerIA = true
            }
            break
        case Moves.tijeras.rawValue:
            if (movePlayer == Moves.papel.rawValue || movePlayer == Moves.lagarto.rawValue) {
                winnerIA = true
            }
            break
        case Moves.lagarto.rawValue:
            if (movePlayer == Moves.papel.rawValue || movePlayer == Moves.spock.rawValue) {
                winnerIA = true
            }
            break
        case Moves.spock.rawValue:
            if (movePlayer == Moves.piedra.rawValue || movePlayer == Moves.tijeras.rawValue) {
                winnerIA = true
            }
            break
        default:
            break;
        }
        
        if (winnerIA) {
            infoLabel.setText("¡Has perdido!")
        } else {
            infoLabel.setText("¡Has ganado!")
        }
        gameOver = true
    }
}
