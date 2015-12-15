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
    
    override func awakeWithContext(context: AnyObject?) {
        super.awakeWithContext(context)
        let url = NSBundle.mainBundle().URLForResource("movieclip", withExtension: "mov")
        self.video.setMovieURL(url!)
    }

}
