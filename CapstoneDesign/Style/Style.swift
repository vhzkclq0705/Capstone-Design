// 버튼이나 라벨 등의 스타일을 설정해 줄 수 있는 파일

import UIKit

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

class ButtonStyle: UIButton {
    // 테두리 굴곡
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
    
    // 버튼 그림자(default: off, ON or off: on)
    @IBInspectable var buttonShadow: Bool = true {
        didSet {
            layer.shadowColor = UIColor.darkGray.cgColor
            layer.shadowOpacity = 0.5
            layer.shadowRadius = 5
            layer.shadowOffset = CGSize(width: 0, height: 10)
        }
    }
    
 }

class ViewStyle: UIView {
    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            layer.cornerRadius = cornerRadius
        }
    }
}

// Navigation Back Button
func SetBackButton() -> UIBarButtonItem {
    let backButton = UIBarButtonItem()
    backButton.title = ""
    backButton.tintColor = UIColor.white
    return backButton
}


