//
//  CorrectFoodVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/20.
//

import UIKit
import Alamofire

protocol CompleteCorrectDelegate {
    func didCorrectFoodDone(_ controller: CorrectFoodVC, data: FoodModel)
}

class CorrectFoodVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: CompleteCorrectDelegate?
    var foodModel = FoodModel.sharedFoodModel
    var foodInfo = FoodInfo()
    var correctIndex = [Int]()
    var parameters = [[String: String]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

extension CorrectFoodVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foodModel.countOfFoodList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CorrectFoodCell else { return UITableViewCell() }
        
        let info = foodModel.foodInfo(at: indexPath.row)
        cell.FoodUpdate(info: info)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(indexPath.row)
        correctIndex.append(indexPath.row)
        print("\(foodModel.FoodInfoList[indexPath.row]) 수정 시작")
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CorrectDetailVC") as? CorrectDetailVC else { return }
        
        vc.delegate = self
        vc.foodInfo = foodModel.FoodInfoList[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func CompleteButton(_ sender: Any) {
        // 서버로 correctFoodModel 보내기
        for i in 0...correctIndex.count - 1 {
            parameters.append(["id": foodModel.FoodInfoList[i].id,
                               "foodPurchaseDate": foodModel.FoodInfoList[i].foodPurchaseDate,
                               "foodExpirationDate": foodModel.FoodInfoList[i].foodExpirationDate,
                               "foodMemo": foodModel.FoodInfoList[i].foodMemo])
        }
        if delegate != nil {
            delegate?.didCorrectFoodDone(self, data: foodModel)
        }
        CorrectInfo()
    }
    
    func CorrectInfo() {
        let url = ""
        var request = URLRequest(url: URL(string: url)!)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 10

        // httpBody 에 parameters 추가
        do {
            try request.httpBody = JSONSerialization.data(withJSONObject: parameters)
        } catch {
            print("http Body Error")
        }
        
        AF.request(request).responseJSON { (response) in
            switch response.result {
            case .success(let json):
                if let jsonData = json as? NSDictionary {
                    if let code = jsonData["code"] as? Int {
                        if code == 200 {
                            print("수정 완료")
                            self.navigationController?.popViewController(animated: true)
                        }
                    }
                }
            case .failure(let error):
                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
            }
        }
    }
}

extension CorrectFoodVC: EditCorrectFoodDelegate {
    func didCorrectFoodEditDone(_ controller: CorrectDetailVC, data: FoodInfo) {
        foodInfo = data
        if let index = foodModel.FoodInfoList.firstIndex(where: { $0.foodName == foodInfo.foodName }) {
            foodModel.FoodInfoList[index] = foodInfo
        }
    }
}

class CorrectFoodCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func FoodUpdate(info: FoodInfo) {
        imgView.image = info.image
        nameLabel.text = info.foodName
    }
}
