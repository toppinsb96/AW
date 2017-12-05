//
//  Room.swift
//  ArtisticWalls
//
//  Created by Brandon Toppins on 12/4/17.
//  Copyright © 2017 Adam Neal. All rights reserved.
//

import Foundation

//
//  Project.swift
//  ArtisticWalls
//
//  Created by Adam Neal on 11/15/17.
//  Copyright © 2017 Adam Neal. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Room {
    let cost:String!
    let key:String!
    let itemRef: DatabaseReference?
    
    init(cost:String, key:String = "") {
        self.key = key
        self.cost = cost
        self.itemRef = nil
    }
    init(snapshot:DataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        if let projectCost = (snapshot.value as? NSDictionary)?["cost"] as? String {
            cost = projectCost
        } else {
            cost = ""
        }
    }
}
