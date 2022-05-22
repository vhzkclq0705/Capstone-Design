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
    var emailModel = EmailModel.sharedEmailModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func ShoppingList(_ sender: Any) {
        PushNavi(name: "ShoppingListVC")
    }
    
    @IBAction func Calendar(_ sender: Any) {
        PushNavi(name: "CalendarVC")
    }
    
    @IBAction func Friends(_ sender: Any) {
        EmailInfoGet()
    }
    
    @IBAction func Settings(_ sender: Any) {
        UserInfoGet()
    }
}

extension SelectMenuVC {
    func UserInfoGet() {
<<<<<<< HEAD
        let url = ""
=======
        let url = "http://3.38.150.193:3000/userinfo/config"
>>>>>>> 380ca25 (Code Repactoring 1)
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
                        self.PushNavi(name: "SettingsVC")
                        print("유저 정보 GET 완료")
                    }
                case .failure(let error):
                    print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                }
            }
    }
    
    func EmailInfoGet() {
<<<<<<< HEAD
        let url = ""
=======
        let url = "http://3.38.150.193:3000/userinfo/search"
>>>>>>> 380ca25 (Code Repactoring 1)
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json;charset=utf-8", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    if let data = json as? NSDictionary {
                        if let email = data["resultUser"] as? [NSDictionary] {
                            do {
                                let emailData = try JSONSerialization.data(withJSONObject: email, options: .prettyPrinted)
                                
                                let dataModel = try JSONDecoder().decode([EmailInfo].self, from: emailData)
                                if dataModel.count > 1 {
                                    for i in 0...dataModel.count - 1 {
                                        self.emailModel.emailInfoList.append(dataModel[i])
                                    }
                                    self.PushNavi(name: "FriendsVC")
                                }
                                print("이메일 리스트 GET 완료.")
                            } catch {
                                print(error.localizedDescription)
                            }
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
