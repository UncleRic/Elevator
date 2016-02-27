//
//  Elevator.swift
//  Elevator
//
//  Created by Frederick C. Lee on 2/23/16.
//  Copyright © 2016 Swift International. All rights reserved.
//

import Foundation

class Elevator:NSObject {
    var id = "A"
    var currentFloor:Int = 0
    var selectedFloors = [Int]()
    var isUpwardBound = false
    var inTransit = false
    
    init(id:String) {
        self.id = id
    }
}
