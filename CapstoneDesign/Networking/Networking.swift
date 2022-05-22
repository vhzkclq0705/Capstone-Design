//
//  Networking.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/02.
//

import Foundation
import Alamofire

func Alert2(title: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "확인", style: .cancel)
    
    alert.addAction(defaultAction)
    
    return alert
}

enum StatusCode {
    case success
    case fail
    case server
}

func networking(url: URL, method: HTTPMethod, params: Parameters?, completion: @escaping(NSDictionary, StatusCode) -> Void) {
    var statusCode: StatusCode = .fail
    AF.request(url,
               method: method,
               parameters: params,
               encoding: JSONEncoding.default,
               headers: ["Content-Type":"application/json;charset=utf-8", "Accept":"application/json"])
    .responseJSON { (response) in
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
            completion(error as! NSDictionary, statusCode)
            print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
        }
    }
}

private let baseURL = Address.base.address

func login(_ params: [String: String], completion: @escaping(StatusCode) -> Void) {
    guard let url = URL(string: baseURL + Address.login.address) else { return }
    
    networking(url: url, method: .post, params: params) { _, code in
        completion(code)
    }
}

func getFood(completion: @escaping([Food], StatusCode) -> Void) {
    guard let url = URL(string: baseURL + Address.foodGet.address) else { return }
    
    networking(url: url, method: .get, params: nil) { data, code in
        if let food = data["resultUser"] as? [NSDictionary] {
            do {
                let foodData = try JSONSerialization.data(withJSONObject: food, options: .prettyPrinted)
                let dataModel = try JSONDecoder().decode([Food].self, from: foodData)

                completion(dataModel, code)
            } catch {
                print(error.localizedDescription)
                completion([], code)
            }
        }
    }
}


