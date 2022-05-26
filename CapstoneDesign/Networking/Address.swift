//
//  Address.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/03.
//

import Foundation

enum Address: String {
    case base
    case login
    case register
    case foodGet
    case foodAdd
    case foodDelete
    case foodCorrect
    case userInfo
    case emailGet
    case friendGet
    case crawling
    
    var address: String {
        switch self {
        case .base: return "http://3.38.150.193:3000/"
        case .login: return "user/login"
        case .register: return "user/signup"
        case .foodGet: return "food/config"
        case .foodAdd: return "food/addFood"
        case .foodDelete: return "food/delfood"
        case .foodCorrect: return "food/changeinfo"
        case .userInfo: return "userinfo/config"
        case .emailGet: return "userinfo/search"
        case .friendGet: return "userinfo/otheruser"
        default: return "https://www.10000recipe.com/recipe/list.html?"
        }
    }
}
