//
//  UserViewModel.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/21.
//

import Foundation

class UserViewModel {
    
    var user = User()
    
    func updateId(_ id: String) {
        user.id = id
    }
    
    func updateAlarm(_ pushAlarm: Bool) {
        user.pushAlarm = pushAlarm
    }
    
    func updateInfoOpen(_ userInfoOpen: Bool) {
        user.userInfoOpen = userInfoOpen
    }
}
