//
//  FriendsVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/18.
//

import UIKit

class FriendsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    // 서버에서 인원 받아올 예정
    var friendsList = ["GayKing_HyeonSoo", "Cutie_LeeDong", "Duckmongus", "wooram_qt", "RadoJun"]
    var rowSelected: Int?
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchList = [String]()
    var isFiltering: Bool {
        let isSearching = searchBar.text?.isEmpty == false
        return isSearching
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if searchController.isActive {
            searchController.isActive = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? searchList.count : friendsList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if isFiltering { cell.textLabel?.text = searchList[indexPath.row] }
        else { cell.textLabel?.text = friendsList[indexPath.row] }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        rowSelected = indexPath.row
        
        performSegue(withIdentifier: "showFriends", sender: self)
        
        searchBar.searchTextField.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFriends" {
            let vc = segue.destination as? ShowFriendVC
            if let indexPath = tableView.indexPathForSelectedRow {
                vc?.friendName = friendsList[indexPath.row]
            }
        }
    }
    
}

extension FriendsVC: UISearchBarDelegate {
    // 검색창에 text입력 시
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList = friendsList.filter { $0.contains(searchText) }
        
        tableView.reloadData()
    }
}
