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
    
    var token: String
    var id: String
    var userInfoOpen: Bool
    var pushAlarm: Bool
    
    private init() {
        self.token = ""
        self.id = ""
        self.userInfoOpen = true
        self.pushAlarm = true
    }
}

// 식재료 정보
struct FoodInfo {
    static let sharedFoodInfo = FoodInfo()
    
    var foodID: String          // 식재료 ID
    var foodName: String        // 식재료 이름
    var purchaseDate: String    // 식재료 구매(추가) 날짜
    var expirationDate: String  // 식재료 유통기한
    var memo: String            // 식재료 메모
    
    var image: UIImage? {       // 식재료 아이콘
        return UIImage(named: "\(foodName).jpg")
    }
    
    init () {
        self.foodID = ""
        self.foodName = ""
        self.purchaseDate = ""
        self.expirationDate = ""
        self.memo = ""
    }
    
    init (foodID: String, foodName: String, purchaseDate: String, expirationDate: String, memo: String) {
        self.foodID = foodID
        self.foodName = foodName
        self.purchaseDate = purchaseDate
        self.expirationDate = expirationDate
        self.memo = memo
    }
}

// 식재료 모델
class FoodModel {
    static let sharedFoodModel = FoodModel()
    
    var FoodInfoList: [FoodInfo] = [    // 식재료 정보 리스트
        // 예시 7개
        FoodInfo(foodID: "", foodName: "피망", purchaseDate: "2022-03-17", expirationDate: "2022-06-18", memo: "3개, 마트 구매"),
        FoodInfo(foodID: "", foodName: "버섯", purchaseDate: "2022-03-17", expirationDate: "2022-05-10", memo: "2개, 마트 구매"),
        FoodInfo(foodID: "", foodName: "양배추", purchaseDate: "2022-03-18", expirationDate: "2022-04-18", memo: "1개, 쿠팡이츠 배달"),
        FoodInfo(foodID: "", foodName: "오렌지", purchaseDate: "2022-03-18", expirationDate: "2022-06-18", memo: "3개, 선물받음"),
        FoodInfo(foodID: "", foodName: "당근", purchaseDate: "2022-03-18", expirationDate: "2022-06-18", memo: "3개, 유통기한 모름"),
        FoodInfo(foodID: "", foodName: "무", purchaseDate: "2022-03-19", expirationDate: "2022-07-22", memo: "2개"),
        FoodInfo(foodID: "", foodName: "감자", purchaseDate: "2022-03-20", expirationDate: "2022-09-20", memo: "3개")
    ]
    
    var countOfFoodList: Int {          // 식재료 개수 반환
        return FoodInfoList.count
    }
    
    func foodInfo(at index: Int) -> FoodInfo { // 식재료 정보 반환
        return FoodInfoList[index]
    }
}

// 친구 식재료 모델
class FriendsFoodModel {
    static let sharedFriendsFoodModel = FriendsFoodModel()
    
    var FoodInfoList: [FoodInfo] = [    // 식재료 정보 리스트
        // 예시 5개
        FoodInfo(foodID: "", foodName: "딸기", purchaseDate: "2022-03-17", expirationDate: "2022-06-18", memo: "3개, 마트 구매"),
        FoodInfo(foodID: "", foodName: "양파", purchaseDate: "2022-03-17", expirationDate: "2022-05-10", memo: "2개, 마트 구매"),
        FoodInfo(foodID: "", foodName: "마늘", purchaseDate: "2022-03-18", expirationDate: "2022-04-18", memo: "1개, 쿠팡이츠 배달"),
        FoodInfo(foodID: "", foodName: "대파", purchaseDate: "2022-03-18", expirationDate: "2022-06-18", memo: "3개, 선물받음"),
        FoodInfo(foodID: "", foodName: "양배추", purchaseDate: "2022-03-18", expirationDate: "2022-06-18", memo: "3개, 유통기한 모름"),
    ]
    
    var countOfFoodList: Int {          // 식재료 개수 반환
        return FoodInfoList.count
    }
    
    func foodInfo(at index: Int) -> FoodInfo { // 식재료 정보 반환
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
