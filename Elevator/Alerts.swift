//  Alerts.swift
//  Elevator
//
//  Created by Frederick C. Lee on 2/29/16.
//  Copyright © 2016 Swift International. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import UIKit

enum AlertPurpose:Int {
    case simple // ...generic OK response.
    case floorButton
}

func showAlert(sender sender:UIViewController,
                      withTitle title:String,
                                withMessage msg:String,
                                            alertPurpose:AlertPurpose = .simple) {
    
    dispatch_async(dispatch_get_main_queue(), {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        alertController.view.tintColor = UIColor.greenColor()
        
        switch alertPurpose {
        case .simple:
            var OKAction:UIAlertAction?
            OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                alertController.addAction(OKAction!)
            }
            
        case .floorButton:
            var UpButton:UIAlertAction?
            var DownButton:UIAlertAction?
            UpButton = UIAlertAction(title: "Up", style: .Default) { (action) in
                print("Alert: UpAction")
            }
            DownButton = UIAlertAction(title: "Down", style: .Default) { (action) in
                print("Alert: DownAction")
            }
            alertController.addAction(UpButton!)
            alertController.addAction(DownButton!)
        }
        
        
        sender.presentViewController(alertController, animated: true, completion: nil)
        
    })
}
