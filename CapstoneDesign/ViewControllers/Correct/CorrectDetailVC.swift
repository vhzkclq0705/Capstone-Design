//
//  CorrectDetailVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/21.
//

import UIKit

class CorrectDetailVC: UIViewController, UITableViewDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var foodTitle: UILabel!
    @IBOutlet weak var buyDate: UITextField!
    @IBOutlet weak var endDate: UITextField!
    @IBOutlet weak var memo: UITextView!
    
    let viewModel = CorrectViewModel.shared
    let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: 390, height: 216))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        CreateDatePicker()
        setup()
    }
}

extension CorrectDetailVC { // Action funcs + Custom funcs
    func setup() {
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = SetBackButton()
        
        memo.layer.borderWidth = 1
        memo.layer.borderColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        
        imageView.image = UIImage(named: viewModel.detailFood.name)
        foodTitle.text = viewModel.detailFood.name
        buyDate.text = viewModel.detailFood.purchaseDate
        endDate.text = viewModel.detailFood.expirationDate
        memo.text = viewModel.detailFood.memo
    }

    @IBAction func CompleteButton(_ sender: Any) {
        guard let purchaseDate = buyDate.text, purchaseDate.isEmpty == false,
                let expirationDate = endDate.text, expirationDate.isEmpty == false,
              let memo = memo.text, memo.isEmpty == false else {
            present(Alert("정보를 모두 입력해 주세요."), animated: true)
            return }
        
        viewModel.correctDetail(purchaseDate: purchaseDate, expirationdate: expirationDate, memo: memo)
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
