//
//  ShoppingCell.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/21.
//

import UIKit

class ShoppingCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var checkButton: UIButton!
    @IBOutlet weak var deleteButton: UIButton!
    
    var deleteButtonHandler: (() -> Void)?
}

extension ShoppingCell {
    func updateUI(_ todo: Todo) {
        title.text = todo.memo
    }
    
    @IBAction func checkButtonTapped(_ sender: Any) {
        checkButton.isSelected = !checkButton.isSelected
        title.layer.opacity = checkButton.isSelected ? 0.3 : 1
        checkButton.layer.opacity = checkButton.isSelected ? 0.3 : 1
    }
    
    @IBAction func deleteButtonTapped(_ sender: Any) {
        deleteButtonHandler?()
    }
}
