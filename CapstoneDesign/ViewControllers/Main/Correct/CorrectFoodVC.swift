//
//  CorrectFoodVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/20.
//

import UIKit
import Alamofire

//protocol CompleteCorrectDelegate {
//    func didCorrectFoodDone(_ controller: CorrectFoodVC, data: FoodModel)
//}

class CorrectFoodVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    //var delegate: CompleteCorrectDelegate?
    
    let viewModel = CorrectViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension CorrectFoodVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.counfOfFoods
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CorrectCell else { return UITableViewCell() }
        
        cell.update(viewModel.foods[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CorrectDetailVC") as? CorrectDetailVC else { return }
        
        //vc.delegate = self
        //vc.food = viewModel.foods[indexPath.row]
        viewModel.detailFood = viewModel.foods[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func CompleteButton(_ sender: Any) {
        viewModel.correctFoods()
        self.navigationController?.popViewController(animated: true)
    }
    
}

extension CorrectFoodVC {
    func setup() {
        
    }
}

//extension CorrectFoodVC: EditCorrectFoodDelegate {
//    func didCorrectFoodEditDone(_ controller: CorrectDetailVC, data: FoodInfo) {
//        foodInfo = data
//        if let index = foodModel.FoodInfoList.firstIndex(where: { $0.foodName == foodInfo.foodName }) {
//            foodModel.FoodInfoList[index] = foodInfo
//        }
//    }
//}
