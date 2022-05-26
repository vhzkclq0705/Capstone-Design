//
//  AddCell.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/26.
//

import Foundation
import UIKit

class AddCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func updateUI(_ food: Food) {
        imgView.image = UIImage(named: food.name)
        nameLabel.text = food.name
    }
}
