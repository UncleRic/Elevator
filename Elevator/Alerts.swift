//  Alerts.swift
//  Elevator
//
//  Created by Frederick C. Lee on 2/29/16.
//  Copyright © 2016 Swift International. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import UIKit

enum AlertPurpose:Int {
    case simple // ...generic OK response.
    case geoSetting
    case createHashtag
    case hashtagCreated
    case timed
    case login
    case sendInventations
    case startBliss
    case noVideo
    case missingProfileImage
    case profileSaved
    case settings
}

func showAlert(sender sender:UIViewController,
                      withTitle title:String,
                                withMessage msg:String,
                                            alertPurpose:AlertPurpose = .simple) {
    
    dispatch_async(dispatch_get_main_queue(), {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        alertController.view.tintColor = UIColor.greenColor()
        
        if alertPurpose == .simple {
            var OKAction:UIAlertAction?
            OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                alertController.addAction(OKAction!)
            }
        }
    
        sender.presentViewController(alertController, animated: true, completion: nil)
    
    })
}
