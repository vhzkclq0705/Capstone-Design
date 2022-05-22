//
//  MyFoodCell.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/22.
//

import UIKit

class MyFoodCell: UICollectionViewCell {
    
    static let identifier = "MyFoodCell"
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // 삭제 체크 표시
    @IBOutlet weak var checkView: ViewStyle!
    @IBOutlet weak var checkImg: UIImageView!
    
}

extension MyFoodCell {
    func updateUI(_ food: Food) {
        imgView.image = UIImage(named: "\(food.name).jpg")
        nameLabel.text = food.name
    }
    
    func isDeleting(_ isDeleting: Bool) {
        checkView.isHidden = !isDeleting
        checkView.backgroundColor = .lightGray
    }
    
    func updateDeleteUI() {
        checkImg.isHidden = !checkImg.isHidden
        if checkImg.isHidden {
            checkView.backgroundColor = .lightGray
        } else {
            checkView.backgroundColor = UIColor(named: "lightSky")
        }
    }
}
