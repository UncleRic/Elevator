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
    @IBOutlet weak var leftPanelAWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightPanelAWidthConstraint: NSLayoutConstraint!
    
    // Elevator Carriage B:
    @IBOutlet weak var carriageB: CarriageView!
    @IBOutlet weak var leftPanelBWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightPanelBWidthConstraint: NSLayoutConstraint!
    
    // Elevator Carriage C:
    @IBOutlet weak var carriageC: CarriageView!
    @IBOutlet weak var leftPanelCWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightPanelCWidthConstraint: NSLayoutConstraint!
    
    // Elevator Carriage D:
    @IBOutlet weak var carriageD: CarriageView!
    @IBOutlet weak var leftPanelDWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var rightPanelDWidthConstraint: NSLayoutConstraint!
    
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
        carriageADoorConstraints = [leftPanelAWidthConstraint, rightPanelAWidthConstraint]
        carriageBDoorConstraints = [leftPanelBWidthConstraint, rightPanelBWidthConstraint]
        carriageCDoorConstraints = [leftPanelCWidthConstraint, rightPanelCWidthConstraint]
        carriageDDoorConstraints = [leftPanelDWidthConstraint, rightPanelDWidthConstraint]
    }
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: - Action methods
    
    @IBAction func animateAction(sender: UIBarButtonItem) {
        let infoDict = RideRequestDict()
        NSNotificationCenter.defaultCenter().postNotificationName(kRideRequestNotification, object:nil, userInfo:infoDict)
        
        animatecarriageA(.first)
        animatecarriageB(.penthouse)
        animatecarriageC(.third)
        animatecarriageD(.second)
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
            let infoDict:Dictionary = [kDestinationFloor:sender.view!.tag]
            
            showAlert(sender: self, withTitle: floorString, withMessage: "", userInfo:infoDict, alertPurpose:.floorButton)
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func carriageUpwardBound(currentFloor:Int) {
        
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func carriageDownwardBound(currentFloor:Int) {
        
    }
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: -
    
    func gotoFloor(currentFloor: currentFloorRequestTuple) {
        switch currentFloor.direction {
        case .upwardBound:
            carriageUpwardBound(currentFloor.currentFloor)
        default:
             carriageUpwardBound(currentFloor.currentFloor)
        }
        
    }
}

// ===================================================================================================
// MARK: -

extension BuildingViewController {
    
    func resetElevators(animate:Bool = true) {
        
        var myCenter = self.carriageA.center
        myCenter.y = FloorPosition.ground.rawValue
        
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
        }) { (RepositionCarriages) in
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
            
            // Close/Open Carriage Door:
            if self.carriageADoorConstraints[0].active {
                NSLayoutConstraint.deactivateConstraints(self.carriageADoorConstraints)
            } else {
                NSLayoutConstraint.activateConstraints(self.carriageADoorConstraints)
            }
            self.view.layoutIfNeeded()
            
        }) {(AfterCarriageReposition) in
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                
                self.carriageA.check(FloorPosition.penthouse)
                self.carriageA.currentFloor = FloorTag.penthouse
            })
            
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------
    
    func animatecarriageB(floorTag:FloorTag) {
        
        UIView .animateWithDuration(BuildingViewController.myDuration, animations: {
            var myCenter = self.carriageB.center
            myCenter.y = floorTag.floorPosn()
            self.carriageB.center = myCenter
            
            // Close/Open Carriage Door:
            if self.carriageBDoorConstraints[0].active {
                NSLayoutConstraint.deactivateConstraints(self.carriageBDoorConstraints)
            } else {
                NSLayoutConstraint.activateConstraints(self.carriageBDoorConstraints)
            }
            self.view.layoutIfNeeded()
        }) {(AfterCarriageReposition) in
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                self.carriageB.currentFloor = FloorTag.third
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
            // Close/Open Carriage Door:
            if self.carriageCDoorConstraints[0].active {
                NSLayoutConstraint.deactivateConstraints(self.carriageCDoorConstraints)
            } else {
                NSLayoutConstraint.activateConstraints(self.carriageCDoorConstraints)
            }
            self.view.layoutIfNeeded()
        }) {(AfterCarriageReposition) in
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                self.carriageC.currentFloor = FloorTag.second
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
            // Close/Open Carriage Door:
            if self.carriageDDoorConstraints[0].active {
                NSLayoutConstraint.deactivateConstraints(self.carriageDDoorConstraints)
            } else {
                NSLayoutConstraint.activateConstraints(self.carriageDDoorConstraints)
            }
            self.view.layoutIfNeeded()
        }) {(AfterCarriageReposition) in
            self.carriageD.check(FloorPosition.first)
            self.carriageD.currentFloor = FloorTag.first
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                
            })
        }
    }
}







