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
    var foodModel = FoodModel.sharedFoodModel
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func CompleteLoginButton(_ sender: Any) {
        //guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainNaviVC") else { return }
        
        //self.present(vc, animated: true, completion: nil)
        if inputID.text == "" {
            Alert(title: "이메일을 입력해 주세요.")
        }
        else if inputPW.text == "" {
            Alert(title: "비밀번호를 입력해 주세요.")
        }
        else {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                self.LoginInfoPost()
            }
        }
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
                if let jsonData = json as? NSDictionary {
                    if let code = jsonData["code"] as? Int {
                        if code == 401 {
                            self.Alert(title: "이메일 혹은 비밀번호가 잘못되었습니다.")
                        }
                        else if code == 200 {
                            print("\(self.inputID.text!)으로 로그인 완료")
                            self.FoodInfoGet()
                            self.userInfo.id = self.inputID.text!
                        }
                    }
                }
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
                self.Alert(title: "서버에 연결할 수 없습니다.")
            }
        }
    }
    
    func FoodInfoGet() {
        let url = "http://3.38.150.193:3000/food/config"
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
                        if let food = data["resultUser"] as? [NSDictionary] {
                            do {
                                let foodData = try JSONSerialization.data(withJSONObject: food, options: .prettyPrinted)
                                
                                let dataModel = try JSONDecoder().decode([FoodInfo].self, from: foodData)
                                print("식재료 \(dataModel.count)개 GET")
                                if dataModel.count > 1 {
                                    for i in 0...dataModel.count - 1 {
                                        self.foodModel.FoodInfoList.append(dataModel[i])
                                    }
                                }
                                guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "MainNaviVC") else { return }
                                
                                self.present(vc, animated: true, completion: nil)
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
    
    // 알람 함수
    func Alert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "확인", style: .cancel)
        
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
}
