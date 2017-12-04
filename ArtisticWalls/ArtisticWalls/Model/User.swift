//
//  User.swift
//  ArtisticWalls
//
//  Created by Brandon Toppins on 11/30/17.
//  Copyright © 2017 Adam Neal. All rights reserved.
//

import Foundation
import FirebaseAuth

struct User {
    let uid: String
    let email: String
    
    init(userData: FirebaseAuth.User) {
        uid = userData.uid
        
        if let mail = userData.providerData.first?.email {
            email = mail
        } else {
            email = ""
        }
    }
    
    init(uid:String, email:String) {
        self.uid = uid
        self.email = email
    }
}
