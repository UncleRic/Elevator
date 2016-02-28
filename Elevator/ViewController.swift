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

class BuildingViewController: UIViewController {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @IBAction func animateAction(sender: UIBarButtonItem) {
        
        UIView.animateWithDuration(BuildingViewController.myDuration) {
            var myCenter = self.carriageA.center
            myCenter.y = floor.fifth.rawValue
            self.carriageA.center = myCenter
        }
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @IBAction func resetAction(sender: UIBarButtonItem) {
        UIView.animateWithDuration(BuildingViewController.myDuration) {
            var myCenter = self.carriageA.center
            myCenter.y = floor.ground.rawValue
            self.carriageA.center = myCenter
            
            myCenter = self.carriageB.center
            myCenter.y = floor.ground.rawValue
            self.carriageB.center = myCenter
            
            myCenter = self.carriageC.center
            myCenter.y = floor.ground.rawValue
            self.carriageC.center = myCenter
            
            myCenter = self.carriageD.center
            myCenter.y = floor.ground.rawValue
            self.carriageD.center = myCenter
            
        }
        
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    @IBAction func exitAction(sender: UIBarButtonItem) {
        exit(0)
    }
    
}

