//
//  Networking.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/02.
//

import Foundation
import Alamofire

enum StatusCode {
    case success
    case fail
    case server
}

private func networking(url: URL, method: HTTPMethod, data: Data?, completion: @escaping(NSDictionary, StatusCode) -> Void) {
    var statusCode: StatusCode = .fail
    var request = URLRequest(url: url)
    request.setValue("application/json", forHTTPHeaderField: "Content-Type")
    request.httpBody = data
    request.method = method
    
    AF.request(request).responseJSON { (response) in
        let code = response.response!.statusCode
        switch code {
        case 200...299:
            statusCode = .success
        case 400...499:
            statusCode = .fail
        default:
            statusCode = .server
        }

        switch response.result {
        case .success(let json):
            if let data = json as? NSDictionary {
                completion(data, statusCode)
            }
        case .failure(let error):
            print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
        }
    }
}

private let baseURL = Address.base.address

func loginAPI(_ params: [String: String], completion: @escaping(StatusCode) -> Void) {
    guard let url = URL(string: baseURL + Address.login.address) else { return }
    let data = try! JSONSerialization.data(withJSONObject: params)
    
    networking(url: url, method: .post, data: data) { _, code in
        completion(code)
    }
}

func registAPI(_ params: [String: String], completion: @escaping(StatusCode) -> Void) {
    guard let url = URL(string: baseURL + Address.register.address) else { return }
    let data = try! JSONSerialization.data(withJSONObject: params)
    
    networking(url: url, method: .post, data: data) { _, code in
        completion(code)
    }
}

func getFoodAPI(completion: @escaping([Food]) -> Void) {
    guard let url = URL(string: baseURL + Address.foodGet.address) else { return }
    
    networking(url: url, method: .get, data: nil) { data, code in
        if let food = data["resultUser"] as? [NSDictionary] {
            
            do {
                let foodData = try JSONSerialization.data(withJSONObject: food, options: .prettyPrinted)
                let foods = try JSONDecoder().decode([Food].self, from: foodData)

                completion(foods)
            } catch {
                print(error.localizedDescription)
                completion([])
            }
        }
    }
}

func addFoodAPI(_ params: [[String: String]], completion: @escaping() -> Void) {
    guard let url = URL(string: baseURL + Address.foodAdd.address) else { return }
    let data = try! JSONSerialization.data(withJSONObject: params)
    
    networking(url: url, method: .post, data: data) { _, _ in
        completion()
    }
}

func deleteFoodAPI(_ params: [[String: String]], completion: @escaping() -> Void) {
    guard let url = URL(string: baseURL + Address.foodDelete.address) else { return }
    let data = try! JSONSerialization.data(withJSONObject: params)
    
    networking(url: url, method: .post, data: data) { _, _ in
        completion()
    }
}

func correctFoodAPI(_ params: [[String: String]], completion: @escaping() -> Void) {
    guard let url = URL(string: baseURL + Address.foodCorrect.address) else { return }
    let data = try! JSONSerialization.data(withJSONObject: params)
    
    networking(url: url, method: .put, data: data) { _, _ in
        completion()
    }
}

func getUserInfoAPI(completion: @escaping(Bool, Bool) -> Void) {
    guard let url = URL(string: baseURL + Address.userInfo.address) else { return }
    
    networking(url: url, method: .get, data: nil) { data, _ in
        guard let pushAlarm = data["pushAlarm"] as? Bool,
              let userInfoOpen = data["userInfoOpen"] as? Bool else {
            return }
        completion(pushAlarm, userInfoOpen)
    }
}

func setUserInfoAPI(_ params: [String: Bool], completion: @escaping() -> Void) {
    guard let url = URL(string: baseURL + Address.userInfo.address) else { return }
    let data = try! JSONSerialization.data(withJSONObject: params)
    
    networking(url: url, method: .put, data: data) { _, _ in
        completion()
    }
}

func getEmailAPI(completion: @escaping([Email]) -> Void) {
    guard let url = URL(string: baseURL + Address.emailGet.address) else { return }
    
    networking(url: url, method: .get, data: nil) { data, _ in
        if let email = data["resultUser"] as? [NSDictionary] {
            do {
                let emailData = try JSONSerialization.data(withJSONObject: email, options: .prettyPrinted)
                let emails = try JSONDecoder().decode([Email].self, from: emailData)

                completion(emails)
            } catch {
                print(error.localizedDescription)
                completion([])
            }
        }
    }
}

func getFriendsFoodAPI(_ email: String, completion: @escaping([Food], StatusCode) -> Void) {
    guard let url = URL(string: baseURL + Address.friendGet.address + email) else { return }
    
    networking(url: url, method: .get, data: nil) { data, code in
        if let food = data["msg"] as? [NSDictionary] {
            do {
                let foodData = try JSONSerialization.data(withJSONObject: food, options: .prettyPrinted)
                let foods = try JSONDecoder().decode([Food].self, from: foodData)
                
                completion(foods, code)
            } catch {
                print(error.localizedDescription)
            }
        } else {
            completion([], code)
        }
    }
}
