//
//  AudioInterfaceController.swift
//  Exercise7
//
//  Created by Jose Angel Cuadrado on 2/1/16.
//  Copyright © 2016 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class AudioInterfaceController: WKInterfaceController {

    @IBOutlet var tableView: WKInterfaceTable!
    
    let directory: NSURL? = NSFileManager.defaultManager().URLsForDirectory(.DocumentDirectory, inDomains: .UserDomainMask).first
    
    var files: NSArray?

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        setTitle("Audio")
    }

    override func willActivate() {
        super.willActivate()
        updateFiles()
    }
    
    func updateFiles() {
        do {
            try files = NSFileManager.defaultManager().contentsOfDirectoryAtURL(directory!, includingPropertiesForKeys: nil, options: NSDirectoryEnumerationOptions.SkipsHiddenFiles)
        } catch {
            print("Error")
        }
        
        setupTable()
    }
    
    func setupTable() {
        if let _ = files {
            tableView.setNumberOfRows(files!.count, withRowType: "audioRow")
            for (var i=0; i<files!.count; i++) {
                let row = tableView.rowControllerAtIndex(i) as! AudioRowController
                row.fileLabel.setText(files![i].lastPathComponent)
            }
        }
    }

    override func table(table: WKInterfaceTable, didSelectRowAtIndex rowIndex: Int) {
        presentMediaPlayerControllerWithURL(files![rowIndex] as! NSURL, options: nil) { (didPlayToEnd: Bool, endTime: NSTimeInterval, error: NSError?) -> Void in
            print("didPlayToEnd:\(didPlayToEnd), endTime:\(endTime), error:\(error)")
        }
    }
    
    @IBAction func recordButtonAction() {
        let clipName = "clip\(NSDate()).wav"
        let clipURL = directory?.URLByAppendingPathComponent(clipName)
        
        if (clipURL != nil) {
            let options = [WKAudioRecorderControllerOptionsActionTitleKey:"Guardar",
                WKAudioRecorderControllerOptionsMaximumDurationKey:10,
                WKAudioRecorderControllerOptionsAutorecordKey:false,
                WKAudioRecorderControllerOptionsAlwaysShowActionTitleKey:true]
            
            presentAudioRecorderControllerWithOutputURL(clipURL!, preset: .HighQualityAudio, options: options, completion: { (didSave: Bool, error: NSError?) -> Void in
                if (error == nil) {
                    if (didSave) {
                        print("saved!")
                    } else {
                        do {
                            try NSFileManager.defaultManager().removeItemAtURL(clipURL!)
                            self.updateFiles()
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
    
}
