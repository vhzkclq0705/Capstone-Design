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
    @IBOutlet weak var compleButton: ButtonStyle!
    
    let searchController = UISearchController(searchResultsController: nil)
    let viewModel = AddViewModel.shared
    
    // 우상단 버튼 클릭 시 테이블 뷰가 변경되게 하는 변수
    var isChanged = false
    // 검색창
    var isFiltering: Bool {
        let isSearching = searchBar.text?.isEmpty == false
        return isSearching
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        searchController.isActive = !searchController.isActive
    }
}
extension SearchFoodVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isChanged {
            return viewModel.numOfFoods
        } else {
            return isFiltering ? viewModel.numOfSearching : viewModel.numOfList
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? SearchCell else { return UITableViewCell() }
        
        if isChanged {
            cell.updateUI(viewModel.foods[indexPath.row].name)
        } else {
            isFiltering ? cell.updateUI(viewModel.searchTerm[indexPath.row]) :
            cell.updateUI(viewModel.list[indexPath.row])
        }
        
        tableView.allowsSelection = !isChanged
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        isFiltering ? viewModel.checkAddFood(viewModel.searchTerm[indexPath.row]) :
        viewModel.checkAddFood(viewModel.list[indexPath.row])
        
        compleButton.isEnabled = !viewModel.foods.isEmpty
        searchBar.searchTextField.endEditing(true)
    }
}

extension SearchFoodVC {
    func setup() {
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = SetBackButton()
        
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
    }
    
    func changeState() {
        titleLable.isHidden = isChanged
        searchBar.isHidden = !isChanged
        isChanged = !isChanged
        
        tableView.reloadData()
    }
    
    @IBAction func ShowFoodButton(_ sender: Any) {
        changeState()
    }
    
    @IBAction func CompleteButton(_ sender: Any) {
        if isChanged {
            guard let vc = storyboard?.instantiateViewController(withIdentifier: "SetAddFoodVC") as? SetAddFoodVC else { return }
            viewModel.searchTerm.removeAll()
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            present(Alert("선택된 재료를 확인해 주세요."), animated: true)
        }
        
        changeState()
    }
}

extension SearchFoodVC: UISearchBarDelegate {
    // 검색창에 text입력 시
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searching(searchText)
        
        tableView.reloadData()
    }
}
