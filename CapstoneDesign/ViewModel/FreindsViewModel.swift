//
//  FreindsViewModel.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/28.
//

import Foundation

class FriendsViewModel {
    static let shared = FriendsViewModel()
    
    private init() {}
    
    var emails = [String]()
    var foods = [Food]()
    var searchTerm = [String]()
    var email: String!
    var detail: Food!
    
    var numOfEmails: Int {
        return emails.count
    }
    
    var numOfSearching: Int {
        return searchTerm.count
    }
    
    var numOfFoods: Int {
        return foods.count
    }
    
    func loadEmails(_ myEmail: String, completion: @escaping() -> Void) {
        getEmailAPI() { [weak self] emails in
            let emailString = emails.map { $0.email }
            self?.emails = emailString.filter { $0 != myEmail }
            completion()
            
            print("Load Emails Successed!")
        }
    }
    
    func loadFoods(_ email: String, completion: @escaping(StatusCode) -> Void) {
        getFriendsFoodAPI(email) { [weak self] foods, code in
            self?.foods = foods
            if code == .fail {
                print("Load Friend's Food Failed!")
            } else {
                completion(code)
                print("Load Friend's Food Successed!")
            }
            
        }
    }
    
    func searching(_ term: String) {
        searchTerm = emails.filter { $0.contains(term) }
    }
}
