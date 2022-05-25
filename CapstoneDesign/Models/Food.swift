//
//  EmainModel.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/21.
//

import Foundation

struct Food: Codable, Equatable {
    var id: String?
    var name: String
    var purchaseDate: String
    var expirationDate: String
    var memo: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case name = "foodName"
        case purchaseDate = "foodPurchaseDate"
        case expirationDate = "foodExpirationDate"
        case memo = "foodMemo"
    }
    
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.id == rhs.id
    }
}


