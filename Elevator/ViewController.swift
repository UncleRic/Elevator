//
//  BuildingViewController.swift
//  Elevator
//
//  Created by Frederick C. Lee on 2/23/16.
//  Copyright © 2016 Swift International. All rights reserved.
//

import UIKit

enum floor:CGFloat {
    case top = 30.0
    case fifth = 100.0
    case forth = 170.0
    case third = 240.0
    case second = 310.0
    case first = 380.0
    case ground = 450.0
}

class  BuildingViewController: UIViewController {
    @IBOutlet weak var ricLabel: UILabel!
    @IBOutlet weak var ricLabelConstraint: NSLayoutConstraint!
    
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
    @IBOutlet weak var letCarriagePanelC: UIView!
    @IBOutlet weak var rightCarriagePanelC: UIView!
    
    // Elevator Carriage D:
    @IBOutlet weak var carriageD: UIView!
    @IBOutlet weak var letCarriagePanelD: UIView!
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
    
    override func viewDidLayoutSubviews() {
        originalLeftCarriagePanelFrame = CGRect(x: 0, y: 0, width: 30, height: 60)
        originalRightCarriagePanelFrame = CGRect(x: 30, y: 0, width: 30, height: 60)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @IBAction func animateAction(sender: UIBarButtonItem) {
        animateElevatorA()
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @IBAction func resetAction(sender: UIBarButtonItem) {
        resetElevators()
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @IBAction func exitAction(sender: UIBarButtonItem) {
        exit(0)
    }
}

// ===================================================================================================

extension BuildingViewController {
    
    func resetElevators() {
        
        var myCenter = self.carriageA.center
        myCenter.y = floor.ground.rawValue
        
        UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
            self.leftCarriagePanelA.frame = self.originalLeftCarriagePanelFrame
            self.rightCarriagePanelA.frame = self.originalRightCarriagePanelFrame
        }) { (shit) in
            UIView.animateWithDuration(BuildingViewController.myDuration, animations: {
                
                self.carriageA.center = myCenter
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
            myCenter.y = floor.fifth.rawValue
            self.carriageA.center = myCenter
        }) {(shit) in
            UIView.animateWithDuration(BuildingViewController.myPanelDuration, animations: {
                self.leftCarriagePanelA.frame = leftFrame
                self.rightCarriagePanelA.frame = rightFrame
            })
            
        }
    }
}

