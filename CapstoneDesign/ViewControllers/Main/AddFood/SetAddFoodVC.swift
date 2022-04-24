//
//  SetAddFoodVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/12.
//

import UIKit

class SetAddFoodVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
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
        // 서버로 addFoodModel.FoodInfoList 보내기
        var cnt = 0
        for i in 0...addFoodModel.countOfFoodList - 1 {
            if addFoodModel.FoodInfoList[i].foodPurchaseDate == "" ||
                addFoodModel.FoodInfoList[i].foodExpirationDate == "" ||
                addFoodModel.FoodInfoList[i].foodMemo == "" {
                let alert = UIAlertController(title: "식재료 \(addFoodModel.FoodInfoList[i].foodName!)의 정보를 입력해 주세요.", message: nil, preferredStyle: .alert)
                
                let defaultAction = UIAlertAction(title: "확인", style: .cancel)
                
                alert.addAction(defaultAction)
                present(alert, animated: true, completion: nil)
                
                cnt += 1
                break
            }
        }
        if cnt == 0 {
            for i in 0...addFoodModel.countOfFoodList - 1 {
                foodModel.FoodInfoList.append(addFoodModel.FoodInfoList[i])
            }
            
            self.navigationController?.popToRootViewController(animated: true)
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

class SetAddFoodCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
}
