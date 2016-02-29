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
    
    @IBOutlet weak var groundFloor: UIView!
    @IBOutlet weak var firstFloor: UIView!
    @IBOutlet weak var secondFloor: UIView!
    @IBOutlet weak var thirdFloor: UIView!
    @IBOutlet weak var penthouseFloor: UIView!
    
    // Elevator Carriage A:
    @IBOutlet weak var carriageA: UIView!
    @IBOutlet weak var leftCarriagePanelA: UIView!
    @IBOutlet weak var rightCarriagePanelA: UIView!
    
    // Elevator Carriage B:
    @IBOutlet weak var carriageB: UIView!
    @IBOutlet weak var leftCarriagePanelB: UIView!
    @IBOutlet weak var rightCarriagePanelB: UIView!
    
    // Elevator Carriage C:
    @IBOutlet weak var carriageC: UIView!
    @IBOutlet weak var leftCarriagePanelC: UIView!
    @IBOutlet weak var rightCarriagePanelC: UIView!
    
    // Elevator Carriage D:
    @IBOutlet weak var carriageD: UIView!
    @IBOutlet weak var leftCarriagePanelD: UIView!
    @IBOutlet weak var rightCarriagePanelD: UIView!
    
    
    @IBOutlet weak var carriageABottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var carriageBBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var carriageCBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var carriageDBottomConstraint: NSLayoutConstraint!
    
    static let myDuration:NSTimeInterval = 3.0
    static let myPanelDuration:NSTimeInterval = 1.0
    
    var originalLeftCarriagePanelFrame:CGRect; var originalRightCarriagePanelFrame:CGRect
    
    required init?(coder aDecoder: NSCoder) {
        originalLeftCarriagePanelFrame = CGRectZero; originalRightCarriagePanelFrame = CGRectZero
        super.init(coder: aDecoder)
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    override func viewDidLayoutSubviews() {
        originalLeftCarriagePanelFrame = CGRect(x: 0, y: 0, width: 30, height: 60)
        originalRightCarriagePanelFrame = CGRect(x: 30, y: 0, width: 30, height: 60)
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @IBAction func animateAction(sender: UIBarButtonItem) {
        animateElevatorA()
        animateElevatorB()
        animateElevatorC()
        animateElevatorD()
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
            switch floor {
            case .ground:
                print("Ground Floor")
                
            case .first:
                print("First Floor")
                
            case .second:
                print("Second Floor")
                
            case .third:
                print("Third Floor")
                
            case .penthouse:
                print("The Penthouse")
                
            }
        }
    }
}

// ===================================================================================================
// MARK: -

extension BuildingViewController {
    
    func resetElevators() {
        
        var myCenter = self.carriageA.center
        myCenter.y = FloorPosition.ground.rawValue
        
        UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
            self.leftCarriagePanelA.frame = self.originalLeftCarriagePanelFrame
            self.rightCarriagePanelA.frame = self.originalRightCarriagePanelFrame
            self.leftCarriagePanelB.frame = self.originalLeftCarriagePanelFrame
            self.rightCarriagePanelB.frame = self.originalRightCarriagePanelFrame
            self.leftCarriagePanelC.frame = self.originalLeftCarriagePanelFrame
            self.rightCarriagePanelC.frame = self.originalRightCarriagePanelFrame
            self.leftCarriagePanelD.frame = self.originalLeftCarriagePanelFrame
            self.rightCarriagePanelD.frame = self.originalRightCarriagePanelFrame
            
        }) { (shit) in
            UIView.animateWithDuration(BuildingViewController.myDuration, animations: {
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
    
    func animateElevatorA() {
        var leftFrame = self.leftCarriagePanelA.frame
        leftFrame.size.width = 4
        var rightFrame = self.rightCarriagePanelA.frame
        rightFrame.origin.x = 54
        rightFrame.size.width = 4
        UIView .animateWithDuration(BuildingViewController.myDuration, animations: {
            var myCenter = self.carriageA.center
            myCenter.y = FloorPosition.penthouse.rawValue
            self.carriageA.center = myCenter
        }) {(shit) in
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                self.leftCarriagePanelA.frame = leftFrame
                self.rightCarriagePanelA.frame = rightFrame
            })
            
        }
    }
    
    
    // -----------------------------------------------------------------------------------------------------
    
    func animateElevatorB() {
        var leftFrame = self.leftCarriagePanelB.frame
        leftFrame.size.width = 4
        var rightFrame = self.rightCarriagePanelB.frame
        rightFrame.origin.x = 54
        rightFrame.size.width = 4
        UIView .animateWithDuration(BuildingViewController.myDuration, animations: {
            var myCenter = self.carriageB.center
            myCenter.y = FloorPosition.third.rawValue
            self.carriageB.center = myCenter
        }) {(shit) in
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                self.leftCarriagePanelB.frame = leftFrame
                self.rightCarriagePanelB.frame = rightFrame
            })
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func animateElevatorC() {
        var leftFrame = self.leftCarriagePanelC.frame
        leftFrame.size.width = 4
        var rightFrame = self.rightCarriagePanelC.frame
        rightFrame.origin.x = 54
        rightFrame.size.width = 4
        UIView .animateWithDuration(BuildingViewController.myDuration, animations: {
            var myCenter = self.carriageC.center
            myCenter.y = FloorPosition.second.rawValue
            self.carriageC.center = myCenter
        }) {(shit) in
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                self.leftCarriagePanelC.frame = leftFrame
                self.rightCarriagePanelC.frame = rightFrame
            })
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func animateElevatorD() {
        var leftFrame = self.leftCarriagePanelD.frame
        leftFrame.size.width = 4
        var rightFrame = self.rightCarriagePanelD.frame
        rightFrame.origin.x = 54
        rightFrame.size.width = 4
        UIView .animateWithDuration(BuildingViewController.myDuration, animations: {
            var myCenter = self.carriageD.center
            myCenter.y = FloorPosition.first.rawValue
            self.carriageD.center = myCenter
        }) {(shit) in
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                self.leftCarriagePanelD.frame = leftFrame
                self.rightCarriagePanelD.frame = rightFrame
            })
        }
    }
}






