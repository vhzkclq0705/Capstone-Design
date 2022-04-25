//
//  SelectMenuVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/04/24.
//

import UIKit
import Alamofire

class SelectMenuVC: UIViewController {

    var userInfo = UserInfo.sharedUserInfo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UserInfoGet()
    }
    
    @IBAction func ShoppingList(_ sender: Any) {
        PushNavi(name: "ShoppingListVC")
    }
    
    @IBAction func Calendar(_ sender: Any) {
        PushNavi(name: "CalendarVC")
    }
    
    @IBAction func Friends(_ sender: Any) {
        PushNavi(name: "FriendsVC")
    }
    
    @IBAction func Settings(_ sender: Any) {
        PushNavi(name: "SettingsVC")
    }
}

extension SelectMenuVC {
    func UserInfoGet() {
        let url = "http://3.38.150.193:3000/accountuser/config"
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: URLEncoding.default,
                   headers: ["Content-Type":"application/json", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    if let jsonData = json as? NSDictionary {
                        if let pushAlarm = jsonData["pushAlarm"] as? Bool {
                            self.userInfo.pushAlarm = pushAlarm
                        }
                        if let userInfoOpen = jsonData["userInfoOpen"] as? Bool {
                            self.userInfo.userInfoOpen = userInfoOpen
                        }
                    }
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
    }
    
    func PushNavi(name: String) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "\(name)") else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

class TestVC: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}
