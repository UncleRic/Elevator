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
    var destinationStatus:CarriageStatus = .stationary
    
    var status:carriageDestinationTuple {
        get {
            return (direction:destinationStatus, nextFloor:currentFloor.rawValue)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        NSNotificationCenter.defaultCenter().addObserver(self,
                                                         selector: #selector(CarriageView.handleRideRequest(_:)),
                                                         name:kRideRequestNotification,
                                                         object: nil)
    }
    
    // -----------------------------------------------------------------------------------------------------
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    // -----------------------------------------------------------------------------------------------------
    // Each of Carriage #1..#4 receives this notification.
    // It's here that the closest carriage path to floor is to to be determined; and hence which carriage to summon.
    
    func handleRideRequest(notification:NSNotification) {
        
        let myUserInfo = notification.userInfo
        let destination = myUserInfo![kDestinationFloor] as? String
        
        
        if destination == "penthouse" {
            selectedFloors.append(FloorTag.penthouse.rawValue)
        } else if destination == "third" {
            selectedFloors.append(FloorTag.third.rawValue)
        } else if destination == "second" {
            selectedFloors.append(FloorTag.second.rawValue)
        } else if destination == "first" {
            selectedFloors.append(FloorTag.first.rawValue)
        } else {
            selectedFloors.append(FloorTag.ground.rawValue)
        }
        
        
        switch destinationStatus {
        case .upwardBound:
            selectedFloors = Array(Set(selectedFloors)).sort()
        case .downwardBound:
            selectedFloors = Array(Set(selectedFloors)).sort{$0>$1}
        default:
            selectedFloors.removeAll()
        }
        
        print("Handle Ride Request for id: \(self.tag) to \(destination): \(selectedFloors)")
        
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
            print("Carriage '\(self.tag)' is on the Penthouse.")
        }
    }
    
}

