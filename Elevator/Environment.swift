//  Environment.swift
//  Elevator
//
//  Created by Frederick C. Lee on 2/29/16.
//  Copyright © 2016 Swift International. All rights reserved.
// -----------------------------------------------------------------------------------------------------


import UIKit

let kRideRequestNotification = "RideRequest"
let kDestinationFloor = "destinationFloor"

typealias RideRequestDict = [String:AnyObject]
typealias carriageDestinationTuple = (direction:FloorDirection, nextFloor:Int)

enum FloorPosition:CGFloat {
    case penthouse = 30.0
    case third = 109.0
    case second = 181.0
    case first = 257.0
    case ground = 354.0
}

enum FloorDirection:Int {
    case up = 0
    case down
}

enum FloorTag:Int {
    case ground = 0
    case first
    case second
    case third
    case penthouse
    func desc() -> String {
        switch self {
        case .ground:
            return "Ground Floor"
        case .first:
            return "First Floor"
        case .second:
            return "Second Floor"
        case .third:
            return "Third Floor"
        case .penthouse:
            return "The Penthouse"
        }
    }
    func floorPosn() -> CGFloat {
        switch self {
        case .ground:
            return FloorPosition.ground.rawValue
        case .first:
            return FloorPosition.first.rawValue
        case .second:
            return FloorPosition.second.rawValue
        case .third:
            return FloorPosition.third.rawValue
        case .penthouse:
            return FloorPosition.penthouse.rawValue
        }
    }
}

enum CarriageTag:Int {
    case carriageATag = 1
    case carriageBTag = 2
    case carriageCTag = 3
    case carriageDTag = 4
}

enum CarriageStatus:Int {
    case stationary = 0
    case upwardBound
    case downwardBound
}
