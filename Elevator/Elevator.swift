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
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(Elevator.handleRideRequest),
                                                         name:kRideRequestNotification, object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func handleRideRequest() {
        print("Handle Ride Request for id: \(id)")
    }
    
    func floorCheck(theFloor:FloorPosition) {
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

