//
//  ShoppingCell.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/21.
//

import UIKit

class ShoppingCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var check: UIButton!
    @IBOutlet weak var delete: UIButton!
    var index: Int = 0
    var isChecked: Bool = false
    var delegate: ListButtonDelegate?
    
    @IBAction func checkList(_ sender: Any) {
        self.delegate?.CheckList(index: index)
    }
    
    @IBAction func deleteList(_ sender: Any) {
        self.delegate?.DeleteList(index: index)
    }

}
