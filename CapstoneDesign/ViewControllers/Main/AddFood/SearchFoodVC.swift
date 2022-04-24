//
//  SearchFoodVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/09.
//

import UIKit
import CoreMedia

class SearchFoodVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var addButton: ButtonStyle!
    @IBOutlet weak var titleLable: UILabel!
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var foodList = ["감자", "고추", "당근", "대파", "돼지고기", "딸기", "마늘", "무", "바나나", "버섯", "사과", "생선", "양배추", "양파", "오렌지", "토마토", "포도", "피망"]
    
    // 선택한 재료 리스트
    var selectedFoodList = [String]()
    
    // 우상단 버튼 클릭 시 테이블 뷰가 변경되게 하는 변수
    var changedList = false
    
    // 검색창
    var searchList = [String]()
    var isFiltering: Bool {
        let isSearching = searchBar.text?.isEmpty == false
        return isSearching
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = SetBackButton()
        
        titleLable.isHidden = true
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor

    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if searchController.isActive {
            searchController.isActive = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if changedList {
            return selectedFoodList.count
        }
        else {
            return isFiltering ? searchList.count : foodList.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchFoodCell else { return UITableViewCell() }
        
        if changedList {
            cell.nameLabel.text = selectedFoodList[indexPath.row]
            cell.imgView.image = UIImage(named: "\(selectedFoodList[indexPath.row]).jpg")
            tableView.allowsSelection = false
        }
        else {
            tableView.allowsSelection = true
            if isFiltering {
                cell.nameLabel.text = searchList[indexPath.row]
                cell.imgView.image = UIImage(named: "\(searchList[indexPath.row]).jpg")
            }
            else {
                cell.nameLabel.text = foodList[indexPath.row]
                cell.imgView.image = UIImage(named: "\(foodList[indexPath.row]).jpg")
            }
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let cell = tableView.cellForRow(at: indexPath) as? SearchFoodCell else { return }
        let selectedFood = cell.nameLabel.text
        
        if let index = selectedFoodList.firstIndex(of: selectedFood!) {
            selectedFoodList.remove(at: index)
        }
        else {
            selectedFoodList.append(selectedFood!)
        }
        
        selectedFoodList = Array(Set(selectedFoodList))
        selectedFoodList.sort()
        
        // 우상단 추가된 재료의 개수 표시
        addButton.titleLabel?.text = "추가하기(\(selectedFoodList.count))"
        
        print(selectedFoodList)
        
        searchBar.searchTextField.endEditing(true)
    }
    
    @IBAction func ShowFoodButton(_ sender: Any) {
        changeState()
    }
    
    @IBAction func CompleteButton(_ sender: Any) {
        if changedList {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "SetAddFoodVC") as? SetAddFoodVC else { return }
            vc.resultFoodList = selectedFoodList
            
            self.navigationController?.pushViewController(vc, animated: true)
            changedList = false
        }
        else {
            let alert = UIAlertController(title: "선택된 재료를 확인하세요", message: nil, preferredStyle: .alert)
            
            let defaultAction = UIAlertAction(title: "확인", style: .cancel) {_ in
                self.changeState()
            }
            
            alert.addAction(defaultAction)
            present(alert, animated: true, completion: nil)
        }
        
    }
    
    func changeState() {
        addButton.titleLabel?.text = "추가하기(\(selectedFoodList.count))"
        if changedList {
            titleLable.isHidden = true
            searchBar.isHidden = false
            changedList = false
        }
        else {
            searchBar.isHidden = true
            titleLable.isHidden = false
            changedList = true
        }
        
        tableView.reloadData()
    }
    
}

extension SearchFoodVC: UISearchBarDelegate {
    // 검색창에 text입력 시
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList = foodList.filter { $0.contains(searchText) }
        
        tableView.reloadData()
    }
}

class SearchFoodCell: UITableViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
}
