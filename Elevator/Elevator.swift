//  Elevator.swift
//  Elevator
//
//  Created by Frederick C. Lee on 2/23/16.
//  Copyright © 2016 Swift International. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import Foundation

class Elevator:NSObject {
    var id = "A"
    var currentFloor:Int = 0
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
        print("Class Elevator *Convenience* init.")
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    func handleRideRequest() {
        print("Handle Ride Request for id: \(id)")
    }

}

