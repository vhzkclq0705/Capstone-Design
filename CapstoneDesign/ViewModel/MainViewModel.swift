//
//  MainViewModel.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/21.
//

import Foundation

class MainViewModel {
    static let shared = MainViewModel()
    
    var foods = [Food]()
    var deletedFoods = [Food]()
    var detailFood: Food!
    
    private init() {}
    
    var countOfFoods: Int {
        return foods.count
    }
    
    func checkDeleteFood(_ food: Food) {
        if let index = deletedFoods.firstIndex(of: food) {
            deletedFoods.remove(at: index)
        } else {
            deletedFoods.append(food)
        }
    }
    
    func deleteFoods() {
        FoodManager.shared.deleteFoods(deletedFoods)
        deletedFoods.removeAll()
    }
    
    func loadFoods() {
        self.foods = FoodManager.shared.foods
    }
}
