//
//  RoomA.swift
//  ArtisticWalls
//
//  Created by Adam Neal on 12/5/17.
//  Copyright © 2017 Adam Neal. All rights reserved.
//

import UIKit
import Foundation

class RoomA {
    
    
    var name: String
    var cost: CGFloat
    var width: CGFloat
    var height: CGFloat
    var components: [ComponentA]
    
    init() {
        
        self.name = "Room"
        self.cost = 0.0
        self.width = 0.0
        self.height = 0.0
        components = [ComponentA]()
    }
    
    init(name: String, cost: CGFloat, width: CGFloat, height: CGFloat, components: [ComponentA]) {
        
        self.name = name
        self.cost = cost
        self.width = width
        self.height = height
        self.components = components
    }
    
    
}
