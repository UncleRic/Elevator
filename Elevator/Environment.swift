//  Environment.swift
//  Elevator
//
//  Created by Frederick C. Lee on 2/29/16.
//  Copyright © 2016 Swift International. All rights reserved.
// -----------------------------------------------------------------------------------------------------


import UIKit

let kRideRequestNotification = "RideRequest"

enum FloorPosition:CGFloat {
    case penthouse = 30.0
    case third = 140.0
    case second = 230.0
    case first = 334.0
    case ground = 452.0
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
            return "ground"
        case .first:
            return "first"
        case .second:
            return "second"
        case .third:
            return "third"
        case .penthouse:
            return "penthouse"
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
