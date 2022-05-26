//
//  AddViewModel.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/26.
//

import Foundation

class AddViewModel {
    static let shared = AddViewModel()
    
    private init() {}
    
    let list = ["감자", "고추", "당근", "대파", "돼지고기", "딸기", "마늘", "무", "바나나", "버섯", "사과", "생선", "양배추", "양파", "오렌지", "토마토", "포도", "피망"]
    
    var foods = [Food]()
    var detailFood: Food!
    var searchTerm = [String]()
    var count: Int = 0
    
    var numOfFoods: Int {
        return foods.count
    }
    
    var numOfList: Int {
        return list.count
    }
    
    var numOfSearching: Int {
        return searchTerm.count
    }
    
    func addDetail(purchaseDate: String, expirationdate: String, memo: String) {
        if let index = foods.firstIndex(of: detailFood) {
            foods[index].purchaseDate = purchaseDate
            foods[index].expirationDate = expirationdate
            foods[index].memo = memo
            
            print("\(foods[index].name) 추가")
        }
        count += 1
    }
    
    func checkAddFood(_ name: String) {
        let names = foods.map { $0.name }
        
        if let index = names.firstIndex(of: name) {
            foods.remove(at: index)
        } else {
            let food = Food(name: name, purchaseDate: "", expirationDate: "", memo: "")
            foods.append(food)
        }
    }
    
    func addFood(completion: @escaping () -> Void) {
        FoodManager.shared.addFoods(foods) { [weak self] in
            self?.foods.removeAll()
            self?.count = 0
            print(FoodManager.shared.foods)
            completion()
        }
    }
    
    func searching(_ term: String) {
        searchTerm = list.filter { $0.contains(term) }
    }
}
