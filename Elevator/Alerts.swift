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
    case carriageButton
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
            let OKAction = UIAlertAction(title: "OK", style: .Default) { (action) in
            }
            alertController.addAction(OKAction)
            sender.presentViewController(alertController, animated: true, completion: nil)
            
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
            
        case .carriageButton:
            var penthouseButton:UIAlertAction?
            var groundButton:UIAlertAction?
            var firstButton:UIAlertAction?
            var secondButton:UIAlertAction?
            var thirdButton:UIAlertAction?
            
            penthouseButton = UIAlertAction(title: "Penthouse", style: .Default) { (action) in
                //                    let targetFloor:CurrentFloorRequestTuple = (direction:CarriageStatus.upwardBound, currentFloor:originFloor)
                //                    (sender as! BuildingViewController).gotoFloor(targetFloor)
            }
            
            thirdButton = UIAlertAction(title: "Third Floor", style: .Default) { (action) in
                //                    let targetFloor:CurrentFloorRequestTuple = (direction:CarriageStatus.downwardBound, currentFloor:originFloor)
                //                    (sender as! BuildingViewController).gotoFloor(targetFloor)
            }
            
            secondButton = UIAlertAction(title: "Second Floor", style: .Default) { (action) in
                //                    let targetFloor:CurrentFloorRequestTuple = (direction:CarriageStatus.downwardBound, currentFloor:originFloor)
                //                    (sender as! BuildingViewController).gotoFloor(targetFloor)
            }
            
            firstButton = UIAlertAction(title: "First Floor", style: .Default) { (action) in
                //                    let targetFloor:CurrentFloorRequestTuple = (direction:CarriageStatus.downwardBound, currentFloor:originFloor)
                //                    (sender as! BuildingViewController).gotoFloor(targetFloor)
            }
            
            groundButton = UIAlertAction(title: "Ground Floor", style: .Default) { (action) in
                //                    let targetFloor:CurrentFloorRequestTuple = (direction:CarriageStatus.downwardBound, currentFloor:originFloor)
                //                    (sender as! BuildingViewController).gotoFloor(targetFloor)
            }
            
            alertController.addAction(penthouseButton!)
            alertController.addAction(thirdButton!)
            alertController.addAction(secondButton!)
            alertController.addAction(firstButton!)
            alertController.addAction(groundButton!)
            
            sender.presentViewController(alertController, animated: true, completion: nil)
        }
    })
}
