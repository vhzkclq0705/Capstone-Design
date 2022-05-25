//
//  FoodManager.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/23.
//

import Foundation

class FoodManager {
    static let shared = FoodManager()
    
    var foods = [Food]()
    
    private init() {}
    
    func createFood(name: String, purchaseDate: String, expirationdate: String, memo: String) -> Food {
        return Food(id: nil, name: name, purchaseDate: purchaseDate, expirationDate: expirationdate, memo: memo)
    }
    
    func addFoods(_ foods: [Food]) {
        
        // 서버로 전송
    }
    
    func deleteFoods(_ foods: [Food]) {
        let params = foods.map { ["id": $0.id!] }
        
        deleteFoodAPI(params) { [weak self] in
            for i in 0...foods.count - 1 {
                if let index = self?.foods.firstIndex(of: foods[i]) {
                    self?.foods.remove(at: index)
                }
            }
        
            print("Delete Successed!")
        }
    }
    
    func correctFood(_ foods: [Food]) {
        let params = foods.map {
            ["id": $0.id!, "foodPurchaseDate": $0.purchaseDate,
             "foodExpirationDate": $0.expirationDate, "foodMemo": $0.memo] }
        
        correctFoodAPI(params) {
            self.foods = foods
            
            print("Correct Successed!")
        }
    }
    
    func loadFoods(completion: @escaping () -> Void) {
        getFoodAPI() { [weak self] foods in
            self?.foods = foods
            
            print("Load Successed!")
            completion()
        }
    }
}
