//
//  ProjectA.swift
//  ArtisticWalls
//
//  Created by Adam Neal on 12/5/17.
//  Copyright © 2017 Adam Neal. All rights reserved.
//

import UIKit
import Foundation

class ProjectA {
    
    
    var name: String
    var cost: CGFloat
    var rooms: [RoomA]
    
    init() {
        
        self.name = "Project Paint"
        self.cost = 0.0
        self.rooms = [RoomA]()
    }
    
    init(name: String, cost: CGFloat, rooms: [RoomA]) {
        
        self.name = name
        self.cost = cost
        self.rooms = rooms
    }
    
    
}
