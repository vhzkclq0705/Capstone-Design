//
//  CorrectFoodVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/20.
//

import UIKit

class CorrectFoodVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var correctFoodModel = FoodModel()
    var correctFoodInfo = FoodInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return correctFoodModel.countOfFoodList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CorrectFoodCell else { return UITableViewCell() }
        
        cell.nameLabel.text = correctFoodModel.FoodInfoList[indexPath.row].foodName
        cell.imgView.image = UIImage(named: "\(correctFoodModel.FoodInfoList[indexPath.row].foodName).jpg")
        
        return cell
    }
    /*
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        <#code#>
    }*/

    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

class CorrectFoodCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
}
