//
//  SettingVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/18.
//  버튼 On/Off 시에 출력되는 오류는 Swift자체의 문제로 무시 가능

import UIKit

class SettingVC: UIViewController {

    @IBOutlet weak var pushAlertLabel: UILabel!
    @IBOutlet weak var pushAlertSwitch: UISwitch!
    @IBOutlet weak var friendsSearchLabel: UILabel!
    @IBOutlet weak var friendsSearchSwitch: UISwitch!
    @IBOutlet weak var id: UILabel!
    
    var userInfo = UserInfo.sharedUserInfo
    
    override func viewDidLoad() {
        super.viewDidLoad()
        id.text = userInfo.id
        
    }
    
    func InitChecks() {
        if userInfo.pushAlarm {
            pushAlertSwitch.isOn = true
        }
        else {
            pushAlertSwitch.isOn = false
        }
        if userInfo.userInfoOpen {
            friendsSearchSwitch.isOn = true
        }
        else {
            friendsSearchSwitch.isOn = false
        }
    }
    
    @IBAction func PushAlert(_ sender: Any) {
        // 푸시 알림 서버와 연동 필요
        if pushAlertSwitch.isOn {
            pushAlertLabel.text = "유통기한 푸시 알림을 허용합니다."
        }
        else {
            pushAlertLabel.text = "유통기한 푸시 알림을 허용하지 않습니다."
        }
    }
    
    @IBAction func FriendsSearch(_ sender: Any) {
        // 이웃 검색 서버와 연동 필요
        if friendsSearchSwitch.isOn {
            friendsSearchLabel.text = "다른 사람이 식재료를 보는 것을 허용합니다."
        }
        else {
            friendsSearchLabel.text = "다른 사람이 식재료를 보는 것을 허용하지 않습니다."
        }
    }
    
    @IBAction func LogoutButton(_ sender: Any) {
        self.view.window?.rootViewController?.dismiss(animated: false, completion: nil)
    }
    
    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
