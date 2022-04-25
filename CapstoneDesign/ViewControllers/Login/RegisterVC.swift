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
        if inputID.text == "" {
            Alert(title: "이메일을 입력해 주세요.")
        }
        else if inputID.text?.contains("@") == false {
            Alert(title: "이메일 형식으로 입력해 주세요.")
        }
        else if inputPW.text == "" {
            Alert(title: "비밀번호를 입력해 주세요.")
        }
        else if inputPW.text != checkPW.text {
            Alert(title: "비밀번호를 확인해 주세요.")
        }
        else {
            RegisterInfoPost()
        }
    }
    
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

extension RegisterVC {
    // 회원가입 정보 서버로 POST
    func RegisterInfoPost() {
        let url = "http://3.38.150.193:3000/User/signup"
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10
            
        // POST 로 보낼 정보
        let params = ["id":inputID.text, "password":inputPW.text] as Dictionary

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: params, options: [])
        } catch {
            print("http Body Error")
        }
            
        AF.request(request).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                print("POST 성공")
                if let data = json as? NSDictionary {
                    if let code = data["code"] as? Int {
                        if code == 409 {
                            self.Alert(title: "중복된 아이디입니다.")
                        }
                        else {
                            let alert = UIAlertController(title: "회원가입이 완료되었습니다. 로그인을 해 주세요.", message: nil, preferredStyle: .alert)
                            
                            let defaultAction = UIAlertAction(title: "확인", style: .cancel) {_ in
                                self.view.window?.rootViewController?.dismiss(animated: true, completion: nil)
                            }
                            
                            alert.addAction(defaultAction)
                            self.present(alert, animated: true, completion: nil)
                        }
                    }
                }
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                self.Alert(title: "서버에 연결할 수 없습니다.")
            }
        }
    }
    
    func Alert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "확인", style: .cancel)
        
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
