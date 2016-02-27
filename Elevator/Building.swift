//  Building.swift
//  Elevator
//
//  Created by Frederick C. Lee on 2/23/16.
//  Copyright © 2016 Swift International. All rights reserved.
// -----------------------------------------------------------------------------------------------------

import Foundation

class Building:NSObject {
    var floors = 5
    var elevators = [Elevator]()
    
    override init() {
        elevators.append(Elevator(id: "A"))
        elevators.append(Elevator(id: "B"))
        elevators.append(Elevator(id: "C"))
        elevators.append(Elevator(id: "A"))
    }
    
}
