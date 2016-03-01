//  ElevatorCarriage.swift
//
//  Created by Frederick C. Lee on 2/23/16.
//  Copyright © 2016 Swift International. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import Foundation
import UIKit

class CarriageView:UIView {
    var currentFloor:FloorTag = .ground
    var selectedFloors = [Int]()
    var isUpwardBound = false
    var inTransit = false
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
         NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(CarriageView.handleRideRequest(_:)),name:kRideRequestNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func handleRideRequest(notification:NSNotification) {
        let destination = notification.object as? String
        
        if destination == "penthouse" {
            
        } else if destination == "third" {
            
        } else if destination == "second" {
            
        } else if destination == "first" {
            
        } else {
            
        }
        
        print("Handle Ride Request for id: \(self.tag) to \(destination!)")
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func check(theFloor:FloorPosition) {
        switch theFloor {
            case .ground:
                print("Carriage '\(self.tag)' is on the ground floor.")
            case .first:
                print("Carriage '\(self.tag)' is on the first floor.")
            case .second:
                print("Carriage '\(self.tag)' is on the second floor.")
            case .third:
                print("Carriage '\(self.tag)' is on the third floor.")
            case .penthouse:
                print("Carriage '\(self.tag)' is on the fourth floor.")
        }
    }
    
}

