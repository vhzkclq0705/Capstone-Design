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
    
    var token: String?
    var id: String?
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
struct FoodInfo: Codable {
    static let sharedFoodInfo = FoodInfo()
    
    var id: String?             // 식재료 ID
    var foodName: String?           // 식재료 이름
    var foodPurchaseDate: String?       // 식재료 구매(추가) 날짜
    var foodExpirationDate: String?     // 식재료 유통기한
    var foodMemo: String?               // 식재료 메모
    
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
    
    var FoodInfoList: [FoodInfo] = [    // 식재료 정보 리스트
        // 예시 7개
        FoodInfo(id: "", foodName: "피망", foodPurchaseDate: "2022-03-17", foodExpirationDate: "2022-06-18", foodMemo: "3개, 마트 구매"),
        FoodInfo(id: "", foodName: "버섯", foodPurchaseDate: "2022-03-17", foodExpirationDate: "2022-05-10", foodMemo: "2개, 마트 구매"),
        FoodInfo(id: "", foodName: "양배추", foodPurchaseDate: "2022-03-18", foodExpirationDate: "2022-04-18", foodMemo: "1개, 쿠팡이츠 배달"),
        FoodInfo(id: "", foodName: "오렌지", foodPurchaseDate: "2022-03-18", foodExpirationDate: "2022-06-18", foodMemo: "3개, 선물받음"),
        FoodInfo(id: "", foodName: "당근", foodPurchaseDate: "2022-03-18", foodExpirationDate: "2022-06-18", foodMemo: "3개, 유통기한 모름"),
        FoodInfo(id: "", foodName: "무", foodPurchaseDate: "2022-03-19", foodExpirationDate: "2022-07-22", foodMemo: "2개"),
        FoodInfo(id: "", foodName: "감자", foodPurchaseDate: "2022-03-20", foodExpirationDate: "2022-09-20", foodMemo: "3개")
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
        FoodInfo(id: "", foodName: "딸기", foodPurchaseDate: "2022-03-17", foodExpirationDate: "2022-06-18", foodMemo: "3개, 마트 구매"),
        FoodInfo(id: "", foodName: "양파", foodPurchaseDate: "2022-03-17", foodExpirationDate: "2022-05-10", foodMemo: "2개, 마트 구매"),
        FoodInfo(id: "", foodName: "마늘", foodPurchaseDate: "2022-03-18", foodExpirationDate: "2022-04-18", foodMemo: "1개, 쿠팡이츠 배달"),
        FoodInfo(id: "", foodName: "대파", foodPurchaseDate: "2022-03-18", foodExpirationDate: "2022-06-18", foodMemo: "3개, 선물받음"),
        FoodInfo(id: "", foodName: "양배추", foodPurchaseDate: "2022-03-18", foodExpirationDate: "2022-06-18", foodMemo: "3개, 유통기한 모름"),
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
