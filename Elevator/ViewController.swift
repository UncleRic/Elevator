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
    
    @IBOutlet weak var carriageA: UIView!
    @IBOutlet weak var leftCarriagePanelA: UIView!
    @IBOutlet weak var rightCarriagePanelA: UIView!
    
    
    
    @IBOutlet weak var carriageB: UIView!
    @IBOutlet weak var carriageC: UIView!
    @IBOutlet weak var carriageD: UIView!
    
    @IBOutlet weak var carriageABottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var carriageBBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var carriageCBottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var carriageDBottomConstraint: NSLayoutConstraint!
    
    let building = Building()
    
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
        let myDuration:NSTimeInterval = 3.0
        UIView.animateWithDuration(myDuration) {
            var myCenter = self.carriageA.center
            myCenter.y = floor.ground.rawValue
            self.carriageA.center = myCenter
        }
    }
    
    @IBAction func exitAction(sender: UIBarButtonItem) {
        exit(0)
    }
    
}

