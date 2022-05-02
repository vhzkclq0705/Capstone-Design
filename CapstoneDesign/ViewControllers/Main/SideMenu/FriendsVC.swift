//
//  FriendsVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/18.
//

import UIKit
import Alamofire

class FriendsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    var emailModel = EmailModel.sharedEmailModel
    var friendFoodModel = FriendsFoodModel.sharedFriendsFoodModel
    var emailToString = [String]()
    var rowSelected: Int?
    
    let searchController = UISearchController(searchResultsController: nil)
    var searchList = [String]()
    var isFiltering: Bool {
        let isSearching = searchBar.text?.isEmpty == false
        return isSearching
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        for i in 0...emailModel.countOfEmailList - 1 {
            emailToString.append(emailModel.emailInfoList[i].email)
        }
        
        searchBar.layer.borderWidth = 1
        searchBar.layer.borderColor = UIColor.white.cgColor
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        emailModel.emailInfoList.removeAll()
        if searchController.isActive {
            searchController.isActive = false
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isFiltering ? searchList.count : emailModel.countOfEmailList
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        
        if isFiltering { cell.textLabel?.text = searchList[indexPath.row] }
        else { cell.textLabel?.text = emailModel.emailInfoList[indexPath.row].email }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.FriendFoodInfoGet(email: emailToString[indexPath.row])
        
        searchBar.searchTextField.endEditing(true)
    }
    
    func FriendFoodInfoGet(email: String) {
        let url = ""
        AF.request(url,
                   method: .get,
                   parameters: nil,
                   encoding: JSONEncoding.default,
                   headers: ["Content-Type":"application/json;charset=utf-8", "Accept":"application/json"])
            .validate(statusCode: 200..<300)
            .responseJSON { (response) in
                switch response.result {
                case .success(let json):
                    if let data = json as? NSDictionary {
                        if let code = data["code"] as? Int {
                            if code == 200 {
                                if let friendFood = data["msg"] as? [NSDictionary] {
                                    do {
                                        let foodData = try JSONSerialization.data(withJSONObject: friendFood, options: .prettyPrinted)
                                        
                                        let dataModel = try JSONDecoder().decode([FriendFoodInfo].self, from: foodData)
                                        if dataModel.count > 1 {
                                            for i in 0...dataModel.count - 1 {
                                                self.friendFoodModel.FoodInfoList.append(dataModel[i])
                                            }
                                            print("친구 식재료 리스트 GET 완료.")
                                            guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "ShowFriendVC") as? ShowFriendVC else { return }
                                            vc.friendName = email
                                                
                                            self.navigationController?.pushViewController(vc, animated: true)
                                        }
                                    } catch {
                                        print(error.localizedDescription)
                                    }
                                }
                            }
                        }
                    }
                case .failure(_):
                    print("조회가 허용되지 않은 유저")
                    self.Alert(title: "조회가 허용되지 않은 유저입니다.")
                }
            }
    }
    
    func Alert(title: String) {
        let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
        
        let defaultAction = UIAlertAction(title: "확인", style: .cancel)
        
        alert.addAction(defaultAction)
        present(alert, animated: true, completion: nil)
    }
    
}

extension FriendsVC: UISearchBarDelegate {
    // 검색창에 text입력 시
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchList = emailToString.filter { $0.contains(searchText) }
        
        tableView.reloadData()
    }
}
