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
    
    var userInfo = UserInfo.sharedUserInfo
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func CompleteLoginButton(_ sender: Any) {
        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainNaviVC") else { return }
        
        self.present(vc, animated: true, completion: nil)
        //LoginInfoPost()
    }
    
}

extension LoginVC {
    func LoginInfoPost() {
        let url = "http://3.38.150.193:3000/User/login"
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
                if let jsonData = json as? NSDictionary {
                    if let code = jsonData["code"] as? Int {
                        if code == 401 {
                            self.Alert(title: "이메일 혹은 비밀번호가 잘못되었습니다.")
                        }
                        else if code == 200 {
                            self.userInfo.id = self.inputID.text!
                            //토큰 값 userInfo에 저장
                            if let token = jsonData["data"] as? NSDictionary {
                                self.userInfo.token = token["access_token"] as? String
                            }
                            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainNaviVC") else { return }
                            
                            self.present(vc, animated: true, completion: nil)
                        }
                    }
                }
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                self.Alert(title: "서버에 연결할 수 없습니다.")
            }
        }
    }
    
    // 알람 함수
    func Alert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "확인", style: .cancel)
        
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
