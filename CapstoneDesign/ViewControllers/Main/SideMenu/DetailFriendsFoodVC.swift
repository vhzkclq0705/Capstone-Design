//
//  DetailFriendsFoodVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/20.
//

import UIKit

class DetailFriendsFoodVC: UIViewController {

    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var purchaseDate: UILabel!
    @IBOutlet weak var expirationDate: UILabel!
    @IBOutlet weak var memo: UITextView!
    
    var foodInfo = FoodInfo()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        foodName.text = foodInfo.foodName
        purchaseDate.text = foodInfo.foodPurchaseDate
        expirationDate.text = foodInfo.foodExpirationDate
        memo.text = foodInfo.foodMemo
        backgroundImg.image = foodInfo.image
    }
    
    
    
    
    @IBAction func CloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func updateViewConstraints() {
        // 숫자가 커질수록 view가 위로 띄어짐
        let TOP_CARD_DISTANCE: CGFloat = 40.0
        
        // view의 높이
        var height: CGFloat = 150.0
        for v in self.stackView.subviews {
            height = height + v.frame.size.height
        }
        
        // view의 높이 적용
        self.view.frame.size.height = height
        // view의 위치 조정
        self.view.frame.origin.y = UIScreen.main.bounds.height - height - TOP_CARD_DISTANCE
        // view의 모서리 각도 조정
        self.view.roundCorners(corners: [.topLeft, .topRight], radius: 10.0)
        super.updateViewConstraints()
    }
}
