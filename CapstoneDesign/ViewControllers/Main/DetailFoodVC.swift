//
//  DetailFoodVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/02/21.
//

import UIKit

class DetailFoodVC: UIViewController {
    
    @IBOutlet weak var backgroundImg: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var foodName: UILabel!
    @IBOutlet weak var purchaseDate: UILabel!
    @IBOutlet weak var expirationDate: UILabel!
    @IBOutlet weak var memo: UITextView!
    
    var food: Food!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillLayoutSubviews() {
        detailUI()
    }
    
}

extension DetailFoodVC {    // Action funcs
    func setup() {
        foodName.text = food.name
        purchaseDate.text = food.purchaseDate
        expirationDate.text = food.expirationDate
        memo.text = food.memo
        backgroundImg.image = UIImage(named: food.name)
    }
    
    func detailUI() {
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
    
    @IBAction func CloseButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func FindRecipeButton(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "RecipeVC") as? RecipeVC else { return }
        
        vc.isDetail = true
        
        present(vc, animated: true, completion: nil)
    }
}
