//
//  User.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/21.
//

import Foundation

struct User {
    static var shared = User()
    
    private init() {}
    
    var id: String!
    
    mutating func setID(_ id: String) {
        self.id = id
    }
}


