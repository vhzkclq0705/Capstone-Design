//
//  FoodViewModel.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/21.
//

import Foundation

class FoodViewModel {
    static let shared = FoodViewModel()
    
    var foods = [Food]()
    var deleteIndex = [Int]()
    
    private init() { }
    
    var countOfFoods: Int {
        return foods.count
    }
    
    
    func createFood(name: String, purchaseDate: String, expirationdate: String, memo: String) -> Food {
        return Food(id: nil, name: name, purchaseDate: purchaseDate, expirationDate: expirationdate, memo: memo)
    }
    
    func addFoods(_ foods: [Food]) {
        self.foods += foods
        // 서버로 전송
    }
    
    func checkDeleteFood(_ index: Int){
        if let foodIndex = deleteIndex.firstIndex(of: index) {
            deleteIndex.remove(at: foodIndex)
        } else {
            deleteIndex.append(index)
        }
        print(deleteIndex)
    }
    
    func deleteFoods() {
        // 리스트 서버로 전송
    }
    
    func foodNames() -> [String] {
        return foods.map { $0.name }
    }
    
    func loadFoods(completion: @escaping () -> Void) {
        getFood() { foods, _ in
            self.foods = foods
       
            completion()
        }
    }
}
