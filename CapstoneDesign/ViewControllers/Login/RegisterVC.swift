//
//  RegisterVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/01/21.
//

import UIKit
import Alamofire

class RegisterVC: UIViewController {

    @IBOutlet weak var inputID: UITextField!
    @IBOutlet weak var inputPW: UITextField!
    @IBOutlet weak var checkPW: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension RegisterVC {  // Action funcs
    @IBAction func Complete(_ sender: Any) {
        guard let id = inputID.text, id.isEmpty == false, id.contains("@") == true else {
            present(Alert("이메일을 확인해 주세요."), animated: true)
            return
        }
        guard let pw = inputPW.text, pw.isEmpty == false,
              let pwch = checkPW.text, pwch.isEmpty == false, pwch == pw else {
            present(Alert("비밀번호를 확인해 주세요."), animated: true)
            return
        }
        
        let params = ["id": id, "password": pw]
        registAPI(params) { [weak self] code in
            if code == .fail {
                self?.present(Alert("중복된 아이디 입니다."), animated: true)
            } else {
                self?.successedAlert()
                print("Regist Successed!")
            }
        }
    }
}

extension RegisterVC {
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func successedAlert() {
        let alert = UIAlertController(title: "회원가입이 완료되었습니다!", message: nil, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "확인", style: .cancel) {_ in
            self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
        }
        
        alert.addAction(defaultAction)
        present(alert, animated: true)
    }
    
}
