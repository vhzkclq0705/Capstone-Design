//
//  CalendarViewModel.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/28.
//

import Foundation

class CalendarViewModel {
    
    var foods = [Food]()
    var expirationDates = [Date]()
    var formatter = DateFormatter()
    
    var numOfFoods: Int {
        return foods.count
    }
    
    func showDate(_ date: Date) -> String {
        return formatter.string(from: date)
    }
    
    func showEvents(_ date: Date) -> Int {
        return expirationDates.contains(date) ? 1 : 0
    }
    
    func selectDate(_ date: Date) {
        //expirationDates = expirationDates.filter { $0 == date }
        foods = FoodManager.shared.foods.filter { $0.expirationDate == formatter.string(from: date) }
    }
    
    func load() {
        formatter.dateFormat = "yyyy-MM-dd"
        expirationDates = FoodManager.shared.foods.map { formatter.date(from: $0.expirationDate)! }
    }
}
