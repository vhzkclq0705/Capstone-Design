//
//  CorrectDetailVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/21.
//

import UIKit

protocol EditCorrectFoodDelegate {
    func didCorrectFoodEditDone(_ controller: CorrectDetailVC, data: FoodInfo)
}

class CorrectDetailVC: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var buyDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var memo: UITextView!
    
    var delegate: EditCorrectFoodDelegate?
    var foodInfo = FoodInfo()
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 390, height: 216))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = SetBackButton()
        
        CreateDatePicker()
        Init()
    }
}

extension CorrectDetailVC { // Action funcs + Custom funcs
    func Init() {
        imageView.image = foodInfo.image
        foodTitle.text = foodInfo.foodName
        buyDate.text = foodInfo.foodPurchaseDate
        endDate.text = foodInfo.foodExpirationDate
        
        memo.layer.borderWidth = 1.0
        memo.layer.borderColor = UIColor.lightGray.cgColor
        if foodInfo.foodMemo == "" {
            memo.text = "메모를 입력하세요."
            memo.textColor = UIColor.lightGray
        }
        else {
            memo.text = foodInfo.foodMemo
            memo.textColor = UIColor.black
        }
    }

    @IBAction func CompleteButton(_ sender: Any) {
        if delegate != nil {
            foodInfo.foodPurchaseDate = buyDate.text!
            foodInfo.foodExpirationDate = endDate.text!
            if memo.text == "메모를 입력하세요." {
                foodInfo.foodMemo = ""
            }
            else {
                foodInfo.foodMemo = memo.text
            }
            delegate?.didCorrectFoodEditDone(self, data: foodInfo)
        }
        
        self.navigationController?.popViewController(animated: true)
    }
    
    // 메모 입력 시작
    func textViewDidBeginEditing(_ textView: UITextView) {
        if memo.textColor == UIColor.lightGray {
            memo.text = ""
            memo.textColor = UIColor.black
        }
    }
    
    // 메모 입력 끝
    func textViewDidEndEditing(_ textView: UITextView) {
        if memo.text.isEmpty {
            memo.text = "메모를 입력하세요."
            memo.textColor = UIColor.lightGray
        }
    }
}

extension CorrectDetailVC { // PickerView
    func CreateDatePicker() {
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        
        buyDate.inputView = datePicker
        endDate.inputView = datePicker
        let toolbar = UIToolbar(frame: CGRect(x: 0.0, y: 0.0, width: 390, height: 44.0))
        let flexible = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancel = UIBarButtonItem(title: "취소", style: .plain, target: nil, action: #selector(tapCancel))
        let barButton = UIBarButtonItem(title: "확인", style: .plain, target: target, action: #selector(tapComplete))
        toolbar.setItems([cancel, flexible, barButton], animated: true)

        
        buyDate.inputAccessoryView = toolbar
        endDate.inputAccessoryView = toolbar
        
        buyDate.inputView = datePicker
        endDate.inputView = datePicker
    }
    
    @objc func tapCancel() {
        self.view.endEditing(true)
    }
    
    @objc func tapComplete() {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .none
        formatter.dateFormat = "yyyy-MM-dd"
        
        if buyDate.isFirstResponder {
            buyDate.text = formatter.string(from: datePicker.date)
        }
        if endDate.isFirstResponder {
            endDate.text = formatter.string(from: datePicker.date)
        }
        self.view.endEditing(true)
    }
}
