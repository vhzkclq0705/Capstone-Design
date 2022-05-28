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
    
    let viewModel = CalendarViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension CalendarVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfFoods
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CalendarCell else { return UITableViewCell() }
        
        cell.updateUI(viewModel.foods[indexPath.row])
        
        return cell
    }
}

extension CalendarVC: FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    // 구매 날짜, 유통기한 있을 시 이벤트 표시
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        return viewModel.showEvents(date)
    }
    
    // 날짜 선택 시
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        detailView.isHidden = false
        detailDate.text = viewModel.showDate(date)
        viewModel.selectDate(date)
        
        tableView.reloadData()
    }
}

extension CalendarVC {
    func setup() {
        viewModel.load()
        
        calendarView.appearance.headerTitleFont = UIFont(name: "TmonMonsoriBlack", size: 25)
        calendarView.appearance.weekdayFont = UIFont(name: "TmonMonsoriBlack", size: 15)
        calendarView.appearance.titleFont = UIFont(name: "TmonMonsoriBlack", size: 15)
    }
}
