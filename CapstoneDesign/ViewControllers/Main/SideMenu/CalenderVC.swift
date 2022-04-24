//
//  CalenderVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/18.
//

import UIKit
import FSCalendar

class CalenderVC: UIViewController {

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var detailDate: UILabel!
    
    let foodModel = FoodModel.sharedFoodModel
    let formatter = DateFormatter()
    var purchaseDates = [Date]()
    var expirationDates = [Date]()
    
    // tableView에 표시할 내용을 담은 list
    var showPurchaseFoods = [FoodInfo]()
    var showExpirationFoods = [FoodInfo]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        formatter.dateFormat = "yyyy-MM-dd"
        calendarView.appearance.headerTitleFont = UIFont(name: "TmonMonsoriBlack", size: 25)
        calendarView.appearance.weekdayFont = UIFont(name: "TmonMonsoriBlack", size: 15)
        calendarView.appearance.titleFont = UIFont(name: "TmonMonsoriBlack", size: 15)
        
        AddFoodDates()
    }
    
    // FoodModel에 있는 재료들의 날짜를 가져옴
    func AddFoodDates() {
        for i in 0...foodModel.countOfFoodList - 1 {
            guard let pDate = foodModel.FoodInfoList[i].foodPurchaseDate else { return }
            purchaseDates.append(formatter.date(from: pDate)!)
            
            guard let eDate = foodModel.FoodInfoList[i].foodExpirationDate else { return }
            expirationDates.append(formatter.date(from: eDate)!)
        }
    }
    
    @IBAction func BackButton(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}

extension CalenderVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showPurchaseFoods.count + showExpirationFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CalenderCustomCell else { return UITableViewCell() }
        
        if showExpirationFoods.isEmpty {
            cell.imgView.image = showPurchaseFoods[indexPath.row].image
            cell.nameLabel.text = showPurchaseFoods[indexPath.row].foodName
            cell.state.text = "구매"
        }
        else {
            cell.imgView.image = showExpirationFoods[indexPath.row].image
            cell.nameLabel.text = showExpirationFoods[indexPath.row].foodName
            cell.state.text = "까지"
            showExpirationFoods.removeFirst()
        }
        
        return cell
    }
    
}

extension CalenderVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    // 구매 날짜, 유통기한 있을 시 이벤트 표시
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.purchaseDates.contains(date) || self.expirationDates.contains(date){
                return 1
            }
            return 0
        }
    
    // 날짜 선택 시
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.detailView.isHidden = false
        self.detailDate.text = formatter.string(from: date)
        
        if let index = foodModel.FoodInfoList.firstIndex(where: {$0.foodExpirationDate == formatter.string(from: date)}) {
            showExpirationFoods.append(foodModel.FoodInfoList[index])
        }
        
        if let index = foodModel.FoodInfoList.firstIndex(where: {$0.foodPurchaseDate == formatter.string(from: date)}) {
            showPurchaseFoods.append(foodModel.FoodInfoList[index])
        }
        
        self.tableView.reloadData()
    }
    
    // 날짜 선택 해제 시
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.detailView.isHidden = true
        showExpirationFoods.removeAll()
        showPurchaseFoods.removeAll()
    }
}

class CalenderCustomCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var state: UILabel!
    
}
