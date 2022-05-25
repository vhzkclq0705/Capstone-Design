//
//  RecipeCell.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/22.
//

import Foundation
import UIKit
import Kingfisher

class RecipeCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setup()
    }
}

extension RecipeCell {
    func setup() {
        layer.borderColor = UIColor.lightGray.cgColor
        layer.borderWidth = 1
    }
    
    func updateUI(_ recipe: Recipe) {
        imgView.kf.setImage(with: recipe.imageURL)
        titleLabel.text = recipe.title
    }
}
