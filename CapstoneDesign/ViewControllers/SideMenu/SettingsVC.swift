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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }

}

extension SettingsVC {
    @IBAction func PushAlert(_ sender: Any) {
        pushAlertLabel.text = pushAlertSwitch.isOn ? "유통기한 푸시 알림을 허용합니다." : "유통기한 푸시 알림을 허용하지 않습니다."
    }
    
    @IBAction func FriendsSearch(_ sender: Any) {
        friendsSearchLabel.text = friendsSearchSwitch.isOn ? "다른 사람이 식재료를 보는 것을 허용합니다." : "다른 사람이 식재료를 보는 것을 허용하지 않습니다."
    }
    
    @IBAction func LogoutButton(_ sender: Any) {
        let alert = UIAlertController(title: "로그아웃 하시겠습니까?", message: nil, preferredStyle: .alert)
        
        let allowAction = UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
            self?.LogOut() })
        let cancleAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(allowAction)
        alert.addAction(cancleAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    @IBAction func SaveInfo(_ sender: Any) {
        let alert = UIAlertController(title: "저장 하시겠습니까?", message: nil, preferredStyle: .alert)
        
        let allowAction = UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
            self?.AllowSave() })
        let cancleAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(allowAction)
        alert.addAction(cancleAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    
}

extension SettingsVC {
    func setup() {
        id.text = User.shared.id
        
        getUserInfoAPI() { [weak self] pushAlarm, userInfoOpen in
            self?.pushAlertSwitch.isOn = pushAlarm
            self?.pushAlertLabel.text = pushAlarm ? "푸시 알림을 허용합니다." : "푸시 알림을 허용하지 않습니다."
            self?.friendsSearchSwitch.isOn = userInfoOpen
            self?.friendsSearchLabel.text = userInfoOpen ? "다른 사람이 식재료를 보는 것을 허용합니다." : "다른 사람이 식재료를 보는 것을 허용하지 않습니다."
            
            print("Load User Info Successed!")
        }
    }
    
    func LogOut() {
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    func AllowSave() {
        let params = ["userInfoOpen": friendsSearchSwitch.isOn, "pushAlarm": pushAlertSwitch.isOn]
        setUserInfoAPI(params) { [weak self] in
            print("Set User Info Successed!")
            self?.present(Alert("저장이 완료되었습니다."), animated: true)
        }
    }
}
