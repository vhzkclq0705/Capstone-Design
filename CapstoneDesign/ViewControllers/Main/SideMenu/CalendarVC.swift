//
//  CalendarVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/18.
//

import UIKit
import FSCalendar

class CalendarVC: UIViewController {

    @IBOutlet weak var calendarView: FSCalendar!
    @IBOutlet weak var detailView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var detailDate: UILabel!
    
    let foodModel = FoodModel.sharedFoodModel
    let formatter = DateFormatter()
    var expirationDates = [Date]()
    
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
            let eDate = foodModel.FoodInfoList[i].foodExpirationDate
            expirationDates.append(formatter.date(from: eDate)!)
        }
    }
}

extension CalendarVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return showExpirationFoods.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CalendarCustomCell else { return UITableViewCell() }
        
        cell.FoodUpdate(info: showExpirationFoods[indexPath.row])
        
        return cell
    }
}

extension CalendarVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    // 구매 날짜, 유통기한 있을 시 이벤트 표시
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        if self.expirationDates.contains(date){
                return 1
            }
            return 0
        }
    
    // 날짜 선택 시
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        self.detailView.isHidden = false
        self.detailDate.text = formatter.string(from: date)
        
        showExpirationFoods.removeAll()
        foodModel.FoodInfoList.indices.filter{foodModel.FoodInfoList[$0].foodExpirationDate == formatter.string(from: date)}.forEach { showExpirationFoods.append(foodModel.FoodInfoList[$0]) }
        
        self.tableView.reloadData()
    }
}

class CalendarCustomCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func FoodUpdate(info: FoodInfo) {
        imgView.image = info.image
        nameLabel.text = info.foodName
    }
}
