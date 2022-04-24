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
    var addFoodModel = FoodModel()
    var initFoodInfo = FoodInfo(foodName: "", purchaseDate: "", expirationDate: "", memo: "")
    var receiveFoodInfo = FoodInfo(foodName: "", purchaseDate: "", expirationDate: "", memo: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        // SearchFoodVC에서 데이터가 넘어 온 후 초기화
        for name in resultFoodList {
            initFoodInfo.foodName = name
            addFoodModel.FoodInfoList.append(initFoodInfo)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        print(addFoodModel.FoodInfoList)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultFoodList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = resultFoodList[indexPath.row]
        cell.textLabel?.font = UIFont(name: "TmonMonsoriBlack", size: 20)
        cell.textLabel?.textColor = UIColor.darkGray
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SetDetailFoodVC") as? SetDetailFoodVC else { return }
        
        vc.delegate = self
        vc.setFoodName = addFoodModel.FoodInfoList[indexPath.row].foodName
        vc.setBuyDate = addFoodModel.FoodInfoList[indexPath.row].purchaseDate
        vc.setEndDate = addFoodModel.FoodInfoList[indexPath.row].expirationDate
        vc.setMemo = addFoodModel.FoodInfoList[indexPath.row].memo
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func CompleteButton(_ sender: Any) {
        // 서버로 addFoodModel.FoodInfoList 보내기
    }
    
}

extension SetAddFoodVC: EditDelegate {
    func didFoodEditDone(_ controller: SetDetailFoodVC, data: FoodInfo) {
        receiveFoodInfo = data
        if let index = addFoodModel.FoodInfoList.firstIndex(where: { $0.foodName == receiveFoodInfo.foodName }) {
            addFoodModel.FoodInfoList[index] = receiveFoodInfo
        }
    }
}
