//
//  ChatInterfaceController.swift
//  PPTLS
//
//  Created by Jose Angel Cuadrado on 21/1/17.
//  Copyright © 2017 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class ChatInterfaceController: WKInterfaceController {

    @IBOutlet var groupAnswer: WKInterfaceGroup!
    @IBOutlet var answerLabel: WKInterfaceLabel!
    @IBOutlet var audioButton: WKInterfaceButton!
    
    var clipURLRecorded: URL? = nil
    
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        setTitle("Chat")
    }

    @IBAction func answerAction() {
        presentTextInputController(withSuggestions: ["Si", "No"], allowedInputMode: .allowEmoji) { (results) in
            if (results != nil) {
                let textResponse = results!.first! as! String
                self.answerLabel.setText(textResponse)
                self.groupAnswer.setHidden(false)
            }
        }
    }
    
    @IBAction func recordAction() {
        let clipName = "clip.wav"
        let directory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        let clipURL = directory?.appendingPathComponent(clipName)
        
        if (clipURL != nil) {
            let options = [WKAudioRecorderControllerOptionsActionTitleKey:"Guardar",
                           WKAudioRecorderControllerOptionsMaximumDurationKey:10,
                           WKAudioRecorderControllerOptionsAutorecordKey:false,
                           WKAudioRecorderControllerOptionsAlwaysShowActionTitleKey:true] as [String : Any]
            
            presentAudioRecorderController(withOutputURL: clipURL!, preset: .highQualityAudio, options: options, completion: { (didSave, error) in
                if (error == nil) {
                    if (didSave) {
                        self.clipURLRecorded = clipURL!
                        self.audioButton.setHidden(false)
                        print("saved!")
                    } else {
                        do {
                            try FileManager.default.removeItem(at: clipURL!)
                            self.audioButton.setHidden(true)
                            print("canceled")
                        } catch {
                            print("error")
                        }
                    }
                } else {
                    print(error!.localizedDescription)
                }
            })
        }
    }
    
    @IBAction func listenAudioAction() {
        if (clipURLRecorded != nil) {
            presentMediaPlayerController(with: clipURLRecorded!, options: nil) { (didPlayToEnd, endTime, error) in
                print("didPlayToEnd:\(didPlayToEnd), endTime:\(endTime), error:\(error)")
            }
        }
    }
}
