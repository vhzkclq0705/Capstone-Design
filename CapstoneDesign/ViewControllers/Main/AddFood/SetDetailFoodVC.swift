//
//  SetDetailFoodVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/14.
//

import UIKit

protocol EditDelegate {
    func didFoodEditDone(_ controller: SetDetailFoodVC, data: FoodInfo)
}

class SetDetailFoodVC: UIViewController, UITextViewDelegate {

    var delegate: EditDelegate?
    var addFoodInfo = FoodInfo(foodName: "", purchaseDate: "", expirationDate: "", memo: "")
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var buyDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var memo: UITextView!
    
    var setFoodName: String!
    var setBuyDate: String!
    var setEndDate: String!
    var setMemo: String!
    var textFieldDate: UITextField!
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 390, height: 216))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let backButton = UIBarButtonItem()
        backButton.title = ""
        backButton.tintColor = UIColor.white
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        
        CreateDatePicker()
        InitFood()
    }
    
    func InitFood() {
        imageView.image = UIImage(named: "\(setFoodName ?? "미정").jpg")
        foodTitle.text = setFoodName
        addFoodInfo.foodName = setFoodName
        if setBuyDate != "" {
            buyDate.text = setBuyDate
        }
        if setEndDate != "" {
            endDate.text = setEndDate
        }
        
        memo.layer.borderWidth = 1.0
        memo.layer.borderColor = UIColor.lightGray.cgColor
        if setMemo == "" {
            memo.text = "메모를 입력하세요."
            memo.textColor = UIColor.lightGray
        }
        else {
            memo.text = setMemo
            memo.textColor = UIColor.black
        }
        
    }
    
    @IBAction func CompleteButton(_ sender: Any) {
        if delegate != nil {
            addFoodInfo.purchaseDate = buyDate.text!
            addFoodInfo.expirationDate = endDate.text!
            if memo.text == "메모를 입력하세요." {
                addFoodInfo.memo = ""
            }
            else {
                addFoodInfo.memo = memo.text
            }
            delegate?.didFoodEditDone(self, data: addFoodInfo)
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
    
    // 날짜 Pickerview 생성
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


