//
//  Project.swift
//  ArtisticWalls
//
//  Created by Adam Neal on 11/15/17.
//  Copyright © 2017 Adam Neal. All rights reserved.
//

import UIKit
import FirebaseDatabase

struct Project {
    let key:String!
    let content:String!
    let addedByUser:String!
    let itemRef: DatabaseReference?
    
    init(content:String, addedByUser:String, key:String = "") {
        self.key = key
        self.content = content
        self.addedByUser = addedByUser
        self.itemRef = nil
    }
    init(snapshot:DataSnapshot) {
        key = snapshot.key
        itemRef = snapshot.ref
        
        if let projectContent = (snapshot.value as? NSDictionary)?["content"] as? String {
            content = projectContent
        } else {
            content = ""
        }
        
        if let projectUser = (snapshot.value as? NSDictionary)?["addedByUser"] as? String {
            addedByUser = projectUser
        } else {
            addedByUser = ""
        }
    }
    func toAny() -> Any {
        return ["content": content, "addedByUser": addedByUser]
    }
}
