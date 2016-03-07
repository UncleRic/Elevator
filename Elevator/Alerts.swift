//  Alerts.swift
//  Elevator
//
//  Created by Frederick C. Lee on 2/29/16.
//  Copyright © 2016 Swift International. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import UIKit

enum AlertPurpose:Int {
    case simple // ...generic OK response.
    case penthouseButton
    case groundButton
    case floorButton
}

func showAlert(sender sender:UIViewController,
                      withTitle title:String,
                                withMessage msg:String,
                                            userInfo:[String:AnyObject]?,
                                            alertPurpose:AlertPurpose = .simple) {
    
    dispatch_async(dispatch_get_main_queue(), {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .Alert)
        alertController.view.tintColor = UIColor.brownColor()
        
        switch alertPurpose {
        case .simple:
            var OKAction:UIAlertAction?
            OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
                alertController.addAction(OKAction!)
            }
            
        case .penthouseButton:
            var DownButton:UIAlertAction?
            
            if let originFloor = userInfo?[kDestinationFloor] as? Int {
                
                DownButton = UIAlertAction(title: "Down", style: .Default) { (action) in
                    let targetFloor:CurrentFloorRequestTuple = (direction:CarriageStatus.downwardBound, currentFloor:originFloor)
                    (sender as! BuildingViewController).gotoFloor(targetFloor)
                }
                
                alertController.addAction(DownButton!)
                sender.presentViewController(alertController, animated: true, completion: nil)
            }
            
        case .groundButton:
            var UpButton:UIAlertAction?
            
            if let originFloor = userInfo?[kDestinationFloor] as? Int {
                
                UpButton = UIAlertAction(title: "Up", style: .Default) { (action) in
                    let targetFloor:CurrentFloorRequestTuple = (direction:CarriageStatus.upwardBound, currentFloor:originFloor)
                    (sender as! BuildingViewController).gotoFloor(targetFloor)
                }
                
                alertController.addAction(UpButton!)
                sender.presentViewController(alertController, animated: true, completion: nil)
            }
            
            
        case .floorButton:
            var UpButton:UIAlertAction?
            var DownButton:UIAlertAction?
            
            if let originFloor = userInfo?[kDestinationFloor] as? Int {
                
                UpButton = UIAlertAction(title: "Up", style: .Default) { (action) in
                    let targetFloor:CurrentFloorRequestTuple = (direction:CarriageStatus.upwardBound, currentFloor:originFloor)
                    (sender as! BuildingViewController).gotoFloor(targetFloor)
                }
                
                DownButton = UIAlertAction(title: "Down", style: .Default) { (action) in
                    let targetFloor:CurrentFloorRequestTuple = (direction:CarriageStatus.downwardBound, currentFloor:originFloor)
                    (sender as! BuildingViewController).gotoFloor(targetFloor)
                }
                
                alertController.addAction(UpButton!)
                alertController.addAction(DownButton!)
                sender.presentViewController(alertController, animated: true, completion: nil)
            }
            
        }
    })
}
