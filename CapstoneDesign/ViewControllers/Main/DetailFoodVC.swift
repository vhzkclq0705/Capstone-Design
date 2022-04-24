//
//  DetailFoodVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/02/21.
//

import UIKit

class DetailFoodVC: UIViewController {
    
    @IBAction func CloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBOutlet weak var stackView: UIStackView!
    
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

// https://stackoverflow.com/a/41197790/225503
extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}
