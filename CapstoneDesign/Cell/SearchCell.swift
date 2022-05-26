//
//  SearchCell.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/21.
//

import UIKit

class SearchCell: UITableViewCell {

    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func updateUI(_ name: String) {
        imgView.image = UIImage(named: name)
        nameLabel.text = name
    }
}
