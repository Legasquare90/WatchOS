//
//  VideoInterfaceController.swift
//  Exercise3
//
//  Created by Jose Angel Cuadrado on 13/12/15.
//  Copyright © 2015 UPSA. All rights reserved.
//

import WatchKit
import Foundation


class VideoInterfaceController: WKInterfaceController {

    @IBOutlet var video: WKInterfaceMovie!
    
    let url = NSBundle.mainBundle().URLForResource("movieclip", withExtension: "mov")

    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        self.video.setMovieURL(url!)
    }

    @IBAction func alternativePlayButtonAction() {
        presentMediaPlayerControllerWithURL(url!, options: nil) { (didPlayToEnd:Bool, endTime:NSTimeInterval, error:NSError?) -> Void in
            
            print("didPlayToEnd:\(didPlayToEnd), endTime:\(endTime), error:\(error)")
        }
    }
    
}
