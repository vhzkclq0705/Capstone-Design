//
//  LoginVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/01/21.
//

import UIKit
import Alamofire

class LoginVC: UIViewController {
    
    @IBOutlet weak var inputID: UITextField!
    @IBOutlet weak var inputPW: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func CompleteLoginButton(_ sender: Any) {
        guard let id = inputID.text, id.isEmpty == false else {
            present(Alert("이메일을 입력해 주세요."), animated: true)
            return
        }
        guard let pw = inputPW.text, pw.isEmpty == false else {
            present(Alert("비밀번호를 입력해 주세요."), animated: true)
            return
        }
        
        let params = ["id": id, "password": pw]
        loginAPI(params) { [weak self] code in
            if code == .fail {
                self?.present(Alert("아이디 혹은 비밀번호를 잘못 입력 하였습니다."), animated: true)
            }
            else {
                print("Login Successed!")
                User.shared.setID(id)
                FoodManager.shared.loadFoods {
                    guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: "MainNaviVC") else { return }
                    
                    self?.present(vc, animated: true)
                }
            }
        }
    }
}
