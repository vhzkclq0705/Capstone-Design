//
//  SetAddFoodVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/12.
//

import UIKit
import Alamofire

class SetAddFoodVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var parameters = [[String: String]]()
    var resultFoodList = [String]()
    var foodModel = FoodModel.sharedFoodModel
    var addFoodModel = AddFoodModel()
    var foodInfo = FoodInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = SetBackButton()
        // SearchFoodVC에서 데이터가 넘어 온 후 초기화
        for name in resultFoodList {
            foodInfo.foodName = name
            addFoodModel.FoodInfoList.append(foodInfo)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultFoodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SetAddFoodCell else { return UITableViewCell() }
        
        cell.nameLabel.text = resultFoodList[indexPath.row]
        cell.imgView.image = UIImage(named: "\(resultFoodList[indexPath.row]).jpg")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SetDetailFoodVC") as? SetDetailFoodVC else { return }
        
        vc.delegate = self
        vc.foodInfo = addFoodModel.FoodInfoList[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
    @IBAction func CompleteButton(_ sender: Any) {
        for i in 0...addFoodModel.countOfFoodList - 1 {
            if addFoodModel.FoodInfoList[i].foodPurchaseDate == "" ||
                addFoodModel.FoodInfoList[i].foodExpirationDate == "" ||
                addFoodModel.FoodInfoList[i].foodMemo == "" {
                let alert = UIAlertController(title: "식재료 '\(addFoodModel.FoodInfoList[i].foodName)'의 정보를 입력해 주세요.", message: nil, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "확인", style: .cancel)
                
                alert.addAction(defaultAction)
                present(alert, animated: true, completion: nil)
            }
            else {
                let addFoodInfo = ["foodName": self.addFoodModel.FoodInfoList[i].foodName,
                                   "foodPurchaseDate": self.addFoodModel.FoodInfoList[i].foodPurchaseDate,
                                   "foodExpirationDate": self.addFoodModel.FoodInfoList[i].foodExpirationDate,
                                   "foodMemo": self.addFoodModel.FoodInfoList[i].foodMemo]
                parameters.append(addFoodInfo)
            }
        }
        if addFoodModel.countOfFoodList != parameters.count {
            parameters.removeAll()
        }
        else {
            NotificationCenter.default.post(name: Notification.Name.name, object: nil)
            AddFoodPost()
        }
    }
    
    func AddFoodPost() {
        let url = ""
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: self.parameters)
        } catch {
            print("http Body Error")
        }
            
        AF.request(request).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                if let jsonData = json as? NSDictionary {
                    if let code = jsonData["code"] as? Int {
                        if code == 200 {
                            for i in 0...self.addFoodModel.countOfFoodList - 1 {
                                self.foodModel.FoodInfoList.append(self.addFoodModel.FoodInfoList[i])
                            }
                            print("식재료 추가 완료")
                            self.navigationController?.popToRootViewController(animated: true)
                        }
                    }
                }
                
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
    
}

extension SetAddFoodVC: EditAddFoodDelegate {
    func didAddFoodEditDone(_ controller: SetDetailFoodVC, data: FoodInfo) {
        foodInfo = data
        if let index = addFoodModel.FoodInfoList.firstIndex(where: { $0.foodName == foodInfo.foodName }) {
            addFoodModel.FoodInfoList[index] = foodInfo
        }
    }
}

extension Notification.Name {
    static let name = Notification.Name("Reload")
}

class SetAddFoodCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
}
