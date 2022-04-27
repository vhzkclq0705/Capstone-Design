//
//  Models.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/17.
//

import Foundation
import UIKit

// 사용자 정보
class UserInfo {
    static let sharedUserInfo = UserInfo()
    
    var id: String?
    var userInfoOpen: Bool
    var pushAlarm: Bool
    
    private init() {
        self.id = ""
        self.userInfoOpen = true
        self.pushAlarm = true
    }
}

// 전체 유저 조회
struct EmailInfo: Codable {
    var email: String
    
    init () {
        self.email = ""
    }
}

// 전체 유저 모델
class EmailModel {
    static let sharedEmailModel = EmailModel()
    
    var emailInfoList = [EmailInfo]()
    
    var countOfEmailList: Int {
        return emailInfoList.count
    }
}

// 식재료 정보
struct FoodInfo: Codable {
    static let sharedFoodInfo = FoodInfo()
    
    var id: String             // 식재료 ID
    var foodName: String           // 식재료 이름
    var foodPurchaseDate: String       // 식재료 구매(추가) 날짜
    var foodExpirationDate: String     // 식재료 유통기한
    var foodMemo: String               // 식재료 메모
    
    var image: UIImage? {           // 식재료 아이콘
        return UIImage(named: "\(foodName ?? "미정").jpg")
    }
    
    init () {
        self.id = ""
        self.foodName = ""
        self.foodPurchaseDate = ""
        self.foodExpirationDate = ""
        self.foodMemo = ""
    }
    
    init (id: String, foodName: String, foodPurchaseDate: String, foodExpirationDate: String, foodMemo: String) {
        self.id = id
        self.foodName = foodName
        self.foodPurchaseDate = foodPurchaseDate
        self.foodExpirationDate = foodExpirationDate
        self.foodMemo = foodMemo
    }
}

// 식재료 모델
class FoodModel {
    static let sharedFoodModel = FoodModel()
    
    var FoodInfoList = [FoodInfo]()    // 식재료 정보 리스트
    
    private init() { }
    
    var countOfFoodList: Int {          // 식재료 개수 반환
        return FoodInfoList.count
    }
    
    func foodInfo(at index: Int) -> FoodInfo { // 식재료 정보 반환
        return FoodInfoList[index]
    }
}

struct FriendFoodInfo: Codable {
    var foodName: String           // 식재료 이름
    var foodPurchaseDate: String       // 식재료 구매(추가) 날짜
    var foodExpirationDate: String     // 식재료 유통기한
    var foodMemo: String               // 식재료 메모
    
    var image: UIImage? {           // 식재료 아이콘
        return UIImage(named: "\(foodName ?? "미정").jpg")
    }
    
    init () {
        self.foodName = ""
        self.foodPurchaseDate = ""
        self.foodExpirationDate = ""
        self.foodMemo = ""
    }
    
    init (foodName: String, foodPurchaseDate: String, foodExpirationDate: String, foodMemo: String) {
        self.foodName = foodName
        self.foodPurchaseDate = foodPurchaseDate
        self.foodExpirationDate = foodExpirationDate
        self.foodMemo = foodMemo
    }
}

// 친구 식재료 모델
class FriendsFoodModel {
    static let sharedFriendsFoodModel = FriendsFoodModel()
    var FoodInfoList = [FriendFoodInfo]()   // 식재료 정보 리스트
    
    var countOfFoodList: Int {          // 식재료 개수 반환
        return FoodInfoList.count
    }
    
    func foodInfo(at index: Int) -> FriendFoodInfo { // 식재료 정보 반환
        return FoodInfoList[index]
    }
}

// 식재료 추가할 때 사용하는 모델
class AddFoodModel {
    var FoodInfoList: [FoodInfo] = []
    
    var countOfFoodList: Int {
        return FoodInfoList.count
    }
}
