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
    
    var carriages = [CarriageView]()
    // MARK: -
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    override func viewDidLayoutSubviews() {
        carriageADoorConstraints = [leftPanelAWidthConstraint, rightPanelAWidthConstraint]
        carriageBDoorConstraints = [leftPanelBWidthConstraint, rightPanelBWidthConstraint]
        carriageCDoorConstraints = [leftPanelCWidthConstraint, rightPanelCWidthConstraint]
        carriageDDoorConstraints = [leftPanelDWidthConstraint, rightPanelDWidthConstraint]
        carriages = [carriageA, carriageB, carriageC, carriageD]
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
    
    @IBAction func infoAction(sender: UIBarButtonItem) {
        
        print ("Carriage A currentfloor: \(carriageA.currentFloor); destinationStatus = \(carriageA.destinationStatus)")
        print ("Carriage B currentfloor: \(carriageB.currentFloor); destinationStatus = \(carriageB.destinationStatus)")
        print ("Carriage C currentfloor: \(carriageC.currentFloor); destinationStatus = \(carriageC.destinationStatus)")
        print ("Carriage D currentfloor: \(carriageD.currentFloor); destinationStatus = \(carriageD.destinationStatus)")
        
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
    // MARK: -
    
    func carriageUpwardBound(currentFloor:Int) {
        var carriageTuples = [CarriageFloorTuple]()
        for carriage in carriages where carriage.destinationStatus == .upwardBound ||
            carriage.destinationStatus == .stationary &&
            carriage.currentFloor.rawValue <= currentFloor {
                if carriage.currentFloor.rawValue == currentFloor {
                    liftCarriage(CarriageTag(rawValue:currentFloor)!, floorTag: FloorTag(rawValue:currentFloor)!)
                    return
                }
                // Get the nearest carriage that's in route:
                let delta = currentFloor - carriage.currentFloor.rawValue
                let myTuple:CarriageFloorTuple = (carriageTag:carriage.tag, currentFloor:delta)
                carriageTuples.append(myTuple)
        }
        
        carriageTuples = carriageTuples.sort() {$0.currentFloor < $1.currentFloor}
        
        let selectedCarriageTag = CarriageTag(rawValue:carriageTuples[0].carriageTag)!
        
        liftCarriage(selectedCarriageTag, floorTag: FloorTag(rawValue:currentFloor)!)
        
    }
    
    
    // -----------------------------------------------------------------------------------------------------
    
    func carriageDownwardBound(currentFloor:Int) {
        for carriage in carriages where carriage.destinationStatus == .downwardBound ||
            carriage.destinationStatus == .stationary &&
            carriage.currentFloor.rawValue >= currentFloor {
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    // MARK: -
    
    func gotoFloor(currentFloor: CurrentFloorRequestTuple) {
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
    
    func liftCarriage(carriage:CarriageTag, floorTag:FloorTag) {
        UIView .animateWithDuration(BuildingViewController.myDuration, animations: {
            switch carriage {
            case .carriageATag:
                self.carriageA.center.y = floorTag.floorPosn()
                print("Carriage A is at: \(floorTag.desc())")
                
            case .carriageBTag:
                self.carriageB.center.y = floorTag.floorPosn()
                print("Carriage B is at: \(floorTag.desc())")
                
            case .carriageCTag:
                self.carriageC.center.y = floorTag.floorPosn()
                print("Carriage C is at: \(floorTag.desc())")
                
            case .carriageDTag:
                self.carriageD.center.y = floorTag.floorPosn()
                print("Carriage D is at: \(floorTag.desc())")
                
            }
            self.view.layoutIfNeeded()
            
        }) {(AfterCarriageReposition) in
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                switch carriage {
                case .carriageATag:
                    if self.carriageADoorConstraints[0].active {
                        NSLayoutConstraint.deactivateConstraints(self.carriageADoorConstraints)
                    } else {
                        NSLayoutConstraint.activateConstraints(self.carriageADoorConstraints)
                    }

                case .carriageBTag:
                    if self.carriageADoorConstraints[0].active {
                        NSLayoutConstraint.deactivateConstraints(self.carriageBDoorConstraints)
                    } else {
                        NSLayoutConstraint.activateConstraints(self.carriageBDoorConstraints)
                    }
                    
                case .carriageCTag:
                    if self.carriageADoorConstraints[0].active {
                        NSLayoutConstraint.deactivateConstraints(self.carriageCDoorConstraints)
                    } else {
                        NSLayoutConstraint.activateConstraints(self.carriageCDoorConstraints)
                    }
                    
                case .carriageDTag:
                    if self.carriageADoorConstraints[0].active {
                        NSLayoutConstraint.deactivateConstraints(self.carriageDDoorConstraints)
                    } else {
                        NSLayoutConstraint.activateConstraints(self.carriageDDoorConstraints)
                    }
                }
                self.view.layoutIfNeeded()
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
//            if self.carriageADoorConstraints[0].active {
//                NSLayoutConstraint.deactivateConstraints(self.carriageADoorConstraints)
//            } else {
//                NSLayoutConstraint.activateConstraints(self.carriageADoorConstraints)
//            }
//            self.view.layoutIfNeeded()
            
        }) {(AfterCarriageReposition) in
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                self.carriageA.currentFloor = floorTag
                print("Carriage A is at: \(floorTag.desc())")
            })
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------
    
    func animatecarriageB(floorTag:FloorTag) {
        
        UIView .animateWithDuration(BuildingViewController.myDuration, animations: {
            var myCenter = self.carriageB.center
            myCenter.y = floorTag.floorPosn()
            self.carriageB.center = myCenter
            
//            // Close/Open Carriage Door:
//            if self.carriageBDoorConstraints[0].active {
//                NSLayoutConstraint.deactivateConstraints(self.carriageBDoorConstraints)
//            } else {
//                NSLayoutConstraint.activateConstraints(self.carriageBDoorConstraints)
//            }
            self.view.layoutIfNeeded()
        }) {(AfterCarriageReposition) in
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                self.carriageB.currentFloor = floorTag
                print("Carriage B is at: \(floorTag.desc())")
            })
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func animatecarriageC(floorTag:FloorTag) {
        
        UIView .animateWithDuration(BuildingViewController.myDuration, animations: {
            var myCenter = self.carriageC.center
            myCenter.y = floorTag.floorPosn()
            self.carriageC.center = myCenter
//            // Close/Open Carriage Door:
//            if self.carriageCDoorConstraints[0].active {
//                NSLayoutConstraint.deactivateConstraints(self.carriageCDoorConstraints)
//            } else {
//                NSLayoutConstraint.activateConstraints(self.carriageCDoorConstraints)
//            }
            self.view.layoutIfNeeded()
        }) {(AfterCarriageReposition) in
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                self.carriageC.currentFloor = floorTag
                print("Carriage C is at: \(floorTag.desc())")
            })
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func animatecarriageD(floorTag:FloorTag) {
        UIView .animateWithDuration(BuildingViewController.myDuration, animations: {
            var myCenter = self.carriageD.center
            myCenter.y = floorTag.floorPosn()
            self.carriageD.center = myCenter
//            // Close/Open Carriage Door:
//            if self.carriageDDoorConstraints[0].active {
//                NSLayoutConstraint.deactivateConstraints(self.carriageDDoorConstraints)
//            } else {
//                NSLayoutConstraint.activateConstraints(self.carriageDDoorConstraints)
//            }
            self.view.layoutIfNeeded()
        }) {(AfterCarriageReposition) in
            self.carriageD.currentFloor = floorTag
            print("Carriage D is at: \(floorTag.desc())")
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                
            })
        }
    }
}







