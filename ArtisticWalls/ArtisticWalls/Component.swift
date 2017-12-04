//
//  Component.swift
//  ArtisticWalls
//
//  Created by Adam Neal on 11/15/17.
//  Copyright © 2017 Adam Neal. All rights reserved.
//

import Foundation

class Component {
    
    // either a room or some additional expense
    // currently assuming additional expense
    
    // properties
    var name: String
    var description: String
    var roomType: Bool
    var cost: Double = 0// convert between string and double

    // if roomType -- and cost will be calculated differently
    var height: Double = 0
    var width: Double = 0
    var wallCount: Double = 0

    
    init?(name: String, description: String, roomType:Bool, cost: Double) {
       
        // Initialize stored properties.
        self.name = name
        self.description = description
        self.roomType = roomType
        self.cost = cost
    }
}
