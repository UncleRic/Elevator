//  BuildingViewController.swift
//  Elevator
//
//  Created by Frederick C. Lee on 2/23/16.
//  Copyright © 2016 Swift International. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import UIKit

class  BuildingViewController: UIViewController {
    @IBOutlet weak var ricLabel: UILabel!
    @IBOutlet weak var ricLabelConstraint: NSLayoutConstraint!
    
    // Floors:
    @IBOutlet weak var groundFloor: UIView!
    @IBOutlet weak var firstFloor: UIView!
    @IBOutlet weak var secondFloor: UIView!
    @IBOutlet weak var thirdFloor: UIView!
    @IBOutlet weak var penthouseFloor: UIView!
    
    // Elevator Carriage A:
    @IBOutlet weak var carriageA: CarriageView!
    
    @IBOutlet weak var leftPanelAConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightPanelAConstraint: NSLayoutConstraint!
    
    // Elevator Carriage B:
    @IBOutlet weak var carriageB: CarriageView!
    @IBOutlet weak var leftPanelBConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightPanelBConstraint: NSLayoutConstraint!
    
    
    // Elevator Carriage C:
    @IBOutlet weak var carriageC: CarriageView!
    @IBOutlet weak var leftPanelCConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightPanelCConstraint: NSLayoutConstraint!
    
    
    // Elevator Carriage D:
    @IBOutlet weak var carriageD: CarriageView!
    @IBOutlet weak var leftPanelDConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var rightPanelDConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var carriageABottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var carriageBBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var carriageCBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var carriageDBottomConstraint: NSLayoutConstraint!
    
    static let myDuration:NSTimeInterval = 3.0
    static let myPanelDuration:NSTimeInterval = 1.0
    
    
    var carriageADoorConstraints = [NSLayoutConstraint]()
    var carriageBDoorConstraints = [NSLayoutConstraint]()
    var carriageCDoorConstraints = [NSLayoutConstraint]()
    var carriageDDoorConstraints = [NSLayoutConstraint]()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLayoutSubviews() {
        carriageADoorConstraints = [leftPanelAConstraint, rightPanelCConstraint]
        carriageBDoorConstraints = [leftPanelBConstraint, rightPanelBConstraint]
        carriageCDoorConstraints = [leftPanelCConstraint, rightPanelCConstraint]
        carriageDDoorConstraints = [leftPanelDConstraint, rightPanelDConstraint]
    }
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - Action methods
    
    @IBAction func animateAction(sender: UIBarButtonItem) {
        let infoDict = RideRequestDict()
        NSNotificationCenter.defaultCenter().postNotificationName(kRideRequestNotification, object:nil, userInfo:infoDict)
        
        animatecarriageA(.ground)
//        animatecarriageB(.penthouse)
//        animatecarriageC(.third)
//        animatecarriageD(.second)
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @IBAction func resetAction(sender: UIBarButtonItem) {
        resetElevators()
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @IBAction func exitAction(sender: UIBarButtonItem) {
        exit(0)
    }
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - Tap Recognizers
    
    @IBAction func handleTapForCarriage(sender:UITapGestureRecognizer) {
        
        if let carriage = CarriageTag(rawValue: sender.view!.tag) {
            switch carriage {
            case .carriageATag:
                print("Carriage A")
            case .carriageBTag:
                print("Carriage B")
            case .carriageCTag:
                print("Carriage C")
            case .carriageDTag:
                print("Carriage D")
            }
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @IBAction func handleTapForFloors(sender: UITapGestureRecognizer) {
        
        if let floor = FloorTag(rawValue: sender.view!.tag) {
            let floorString = floor.desc()
            let infoDict:Dictionary = [kDestinationFloor:floorString]
            
            showAlert(sender: self, withTitle: floorString, withMessage: "", userInfo:infoDict, alertPurpose:.floorButton)
        }
    }
}

// ===================================================================================================
// MARK: -

extension BuildingViewController {
    
    func resetElevators(animate:Bool = true) {
        
        var myCenter = self.carriageA.center
        myCenter.y = FloorPosition.penthouse.rawValue
        
        var myPanelDuration:NSTimeInterval = 0.0
        var myDuration:NSTimeInterval = 0.0
        
        if animate {
            myPanelDuration = BuildingViewController.myPanelDuration
            myDuration = BuildingViewController.myDuration
        }
        
        UIView.animateWithDuration(myPanelDuration, animations: {
            NSLayoutConstraint.activateConstraints(self.carriageADoorConstraints)
            NSLayoutConstraint.activateConstraints(self.carriageBDoorConstraints)
            NSLayoutConstraint.activateConstraints(self.carriageCDoorConstraints)
            NSLayoutConstraint.activateConstraints(self.carriageDDoorConstraints)
            self.view.layoutIfNeeded()
        }) { (shit) in
            UIView.animateWithDuration(myDuration, animations: {
                self.carriageA.center = myCenter
                
                myCenter = self.carriageB.center
                myCenter.y = FloorPosition.ground.rawValue
                self.carriageB.center = myCenter
                
                myCenter = self.carriageC.center
                myCenter.y = FloorPosition.ground.rawValue
                self.carriageC.center = myCenter
                
                myCenter = self.carriageD.center
                myCenter.y = FloorPosition.ground.rawValue
                self.carriageD.center = myCenter
            })
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func animatecarriageA(floorTag:FloorTag) {
        
        UIView .animateWithDuration(BuildingViewController.myDuration, animations: {
            var myCenter = self.carriageA.center
            myCenter.y = floorTag.floorPosn()
            self.carriageA.center = myCenter
            if self.carriageADoorConstraints[0].active {
                NSLayoutConstraint.deactivateConstraints(self.carriageADoorConstraints)
            } else {
                NSLayoutConstraint.activateConstraints(self.carriageADoorConstraints)
            }
            self.view.layoutIfNeeded()
            
        }) {(shit) in
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                
                self.carriageA.check(FloorPosition.penthouse)
            })
            
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------
    
    func animatecarriageB(floorTag:FloorTag) {
        
        UIView .animateWithDuration(BuildingViewController.myDuration, animations: {
            var myCenter = self.carriageB.center
            myCenter.y = floorTag.floorPosn()
            self.carriageB.center = myCenter
            if self.carriageBDoorConstraints[0].active {
                NSLayoutConstraint.deactivateConstraints(self.carriageBDoorConstraints)
            } else {
                NSLayoutConstraint.activateConstraints(self.carriageBDoorConstraints)
            }
            self.view.layoutIfNeeded()
        }) {(shit) in
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                
                self.carriageB.check(FloorPosition.third)
            })
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func animatecarriageC(floorTag:FloorTag) {
        
        UIView .animateWithDuration(BuildingViewController.myDuration, animations: {
            var myCenter = self.carriageC.center
            myCenter.y = floorTag.floorPosn()
            self.carriageC.center = myCenter
            if self.carriageCDoorConstraints[0].active {
                NSLayoutConstraint.deactivateConstraints(self.carriageCDoorConstraints)
            } else {
                NSLayoutConstraint.activateConstraints(self.carriageCDoorConstraints)
            }
            self.view.layoutIfNeeded()
        }) {(shit) in
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                
                self.carriageC.check(FloorPosition.second)
            })
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func animatecarriageD(floorTag:FloorTag) {
        UIView .animateWithDuration(BuildingViewController.myDuration, animations: {
            var myCenter = self.carriageD.center
            myCenter.y = floorTag.floorPosn()
            self.carriageD.center = myCenter
            if self.carriageDDoorConstraints[0].active {
                NSLayoutConstraint.deactivateConstraints(self.carriageDDoorConstraints)
            } else {
                NSLayoutConstraint.activateConstraints(self.carriageDDoorConstraints)
            }
            self.view.layoutIfNeeded()
        }) {(shit) in
            self.carriageD.check(FloorPosition.first)
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                
            })
        }
    }
}







