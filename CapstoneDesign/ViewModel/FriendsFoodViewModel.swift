//
//  FriendsFoodViewModel.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/21.
//

import Foundation

class FriendsFoodViewModel {
    static let sharedFoodModel = FriendsFoodViewModel()
    
    var foods = [Food]()
    
    private init() { }
    
    var countOfFoods: Int {
        return foods.count
    }
    
    func loadFoods() {
        // 서버에서 받아오기
    }
}
