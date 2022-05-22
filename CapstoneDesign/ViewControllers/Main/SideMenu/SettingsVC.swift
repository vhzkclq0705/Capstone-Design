//
//  SettingVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/18.
//  버튼 On/Off 시에 출력되는 오류는 Swift자체의 문제로 무시 가능

import UIKit
import Alamofire

class SettingsVC: UIViewController {

    @IBOutlet weak var pushAlertLabel: UILabel!
    @IBOutlet weak var pushAlertSwitch: UISwitch!
    @IBOutlet weak var friendsSearchLabel: UILabel!
    @IBOutlet weak var friendsSearchSwitch: UISwitch!
    @IBOutlet weak var id: UILabel!
    
    var userInfo = UserInfo.sharedUserInfo
    var foodModel = FoodModel.sharedFoodModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
        InitChecks()
    }

}

extension SettingsVC {   // Action funcs + Custom funcs
    @IBAction func PushAlert(_ sender: Any) {
        if pushAlertSwitch.isOn {
            pushAlertLabel.text = "유통기한 푸시 알림을 허용합니다."
        }
        else {
            pushAlertLabel.text = "유통기한 푸시 알림을 허용하지 않습니다."
        }
    }
    
    @IBAction func FriendsSearch(_ sender: Any) {
        if friendsSearchSwitch.isOn {
            friendsSearchLabel.text = "다른 사람이 식재료를 보는 것을 허용합니다."
        }
        else {
            friendsSearchLabel.text = "다른 사람이 식재료를 보는 것을 허용하지 않습니다."
        }
    }
    
    @IBAction func LogoutButton(_ sender: Any) {
        let alert = UIAlertController(title: "로그아웃 하시겠습니까?", message: nil, preferredStyle: .alert)
        
        let allowAction = UIAlertAction(title: "확인", style: .default, handler: { action in self.LogOut() })
        let cancleAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(allowAction)
        alert.addAction(cancleAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func SaveInfo(_ sender: Any) {
        let alert = UIAlertController(title: "저장 하시겠습니까?", message: nil, preferredStyle: .alert)
        
        let allowAction = UIAlertAction(title: "확인", style: .default, handler: { action in self.AllowSave() })
        let cancleAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(allowAction)
        alert.addAction(cancleAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func LogOut() {
        self.foodModel.FoodInfoList.removeAll()
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    func AllowSave() {
        self.SetInfo()
    }
    
    func InitChecks() {
        self.id.text = self.userInfo.id
        
        if userInfo.pushAlarm {
            pushAlertSwitch.isOn = true
            pushAlertLabel.text = "유통기한 푸시 알림을 허용합니다."
        }
        else {
            pushAlertSwitch.isOn = false
            pushAlertLabel.text = "유통기한 푸시 알림을 허용하지 않습니다."
        }
        if userInfo.userInfoOpen {
            friendsSearchSwitch.isOn = true
            friendsSearchLabel.text = "다른 사람이 식재료를 보는 것을 허용합니다."
        }
        else {
            friendsSearchSwitch.isOn = false
            friendsSearchLabel.text = "다른 사람이 식재료를 보는 것을 허용하지 않습니다."
        }
    }
    
    func SetInfo() {
<<<<<<< HEAD
        let url = ""
=======
        let url = "http://3.38.150.193:3000/userinfo/config"
>>>>>>> 380ca25 (Code Repactoring 1)
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10

        let params = ["userInfoOpen": friendsSearchSwitch.isOn, "pushAlarm": pushAlertSwitch.isOn] as Dictionary

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }

        AF.request(request).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                if let jsonData = json as? NSDictionary {
                    if let code = jsonData["code"] as? Int {
                        if code == 200 {
                            print("정보 저장 완료")
                        }
                    }
                }
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
}
