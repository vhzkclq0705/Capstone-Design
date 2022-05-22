//
//  User.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/21.
//

import Foundation

struct User {
    var id: String
    var userInfoOpen: Bool
    var pushAlarm: Bool
    
    init() {
        self.id = ""
        self.userInfoOpen = false
        self.pushAlarm = false
    }
}


