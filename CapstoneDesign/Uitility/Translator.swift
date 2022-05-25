//
//  Translator.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/23.
//

import Foundation

func translator(_ foods: [String]) -> [String] {
    var changedFoods = foods
    for i in 0...foods.count - 1 {
        switch foods[i] {
        case "carrot":
            changedFoods[i] = "당근"
        case "cucumber":
            changedFoods[i] = "오이"
        case "garlic":
            changedFoods[i] = "마늘"
        case "onion":
            changedFoods[i] = "양파"
        case "potato":
            changedFoods[i] = "감자"
        case "banana":
            changedFoods[i] = "바나나"
        case "pengi_mushroom":
            changedFoods[i] = "팽이버섯"
        case "pork":
            changedFoods[i] = "돼지고기"
        case "strawberry":
            changedFoods[i] = "딸기"
        default:
            changedFoods[i] = "Unknown"
        }
    }
    
    return changedFoods
}
