//
//  CorrectFoodVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/20.
//

import UIKit

protocol CompleteCorrectDelegate {
    func didCorrectFoodDone(_ controller: CorrectFoodVC, data: FoodModel)
}

class CorrectFoodVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    var delegate: CompleteCorrectDelegate?
    var foodModel = FoodModel.sharedFoodModel
    var foodInfo = FoodInfo()
    
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
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CorrectDetailVC") as? CorrectDetailVC else { return }
        
        vc.delegate = self
        vc.foodInfo = foodModel.FoodInfoList[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func CompleteButton(_ sender: Any) {
        // 서버로 correctFoodModel 보내기
        if delegate != nil {
            delegate?.didCorrectFoodDone(self, data: foodModel)
        }
        
        self.navigationController?.popViewController(animated: true)
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
