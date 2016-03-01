//  Elevator.swift
//  Elevator
//
//  Created by Frederick C. Lee on 2/23/16.
//  Copyright © 2016 Swift International. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import Foundation

class Elevator:NSObject {
    var id = "A"
    var currentFloor:FloorTag = .ground
    var selectedFloors = [Int]()
    var isUpwardBound = false
    var inTransit = false
    
    override init() {
        super.init()
    }
    
    convenience init(id:String) {
        self.init()
        self.id = id
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Elevator.handleRideRequest(_:)),
                                                         name:kRideRequestNotification, object: nil)
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
        
        print("Handle Ride Request for id: \(id) to \(destination!)")
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    func check(theFloor:FloorPosition) {
        switch theFloor {
            case .ground:
                print("Carriage '\(id)' is on the ground floor.")
            case .first:
                print("Carriage '\(id)' is on the first floor.")
            case .second:
                print("Carriage '\(id)' is on the second floor.")
            case .third:
                print("Carriage '\(id)' is on the third floor.")
            case .penthouse:
                print("Carriage '\(id)' is on the fourth floor.")
        }
    }
    
}

