//
//  CorrectCell2.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/21.
//

import UIKit

class CorrectCell2: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func update(_ food: Food) {
        imgView.image = UIImage(named: food.name)
        nameLabel.text = food.name
    }

}
