//
//  FriendsVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/18.
//

import UIKit
import Alamofire

class FriendsVC: UIViewController {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = FriendsViewModel.shared
    let searchController = UISearchController(searchResultsController: nil)
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

extension FriendsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? viewModel.numOfSearching : viewModel.numOfEmails
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        cell.textLabel?.text = isFiltering ? viewModel.searchTerm[indexPath.row] :
        viewModel.emails[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.email = viewModel.emails[indexPath.row]
        viewModel.loadFoods(viewModel.emails[indexPath.row]) { [weak self] code in
            if code == .success {
                guard let vc = self?.storyboard?.instantiateViewController(withIdentifier: "ShowFriendVC") as? ShowFriendVC else { return }
                
                self?.navigationController?.pushViewController(vc, animated: true)
            } else {
                self?.present(Alert("조회가 허용되지 않은 유저입니다."), animated: true)
            }
        }
        
        searchBar.searchTextField.endEditing(true)
    }
}

extension FriendsVC {
    func setup() {
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
        
        viewModel.loadEmails(User.shared.id) { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

extension FriendsVC: UISearchBarDelegate {
    // 검색창에 text입력 시
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searching(searchText)
        
        tableView.reloadData()
    }
}
