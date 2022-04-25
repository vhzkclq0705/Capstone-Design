//
//  ShoppingListVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/18.
//

import UIKit

protocol ListButtonDelegate {
    func CheckList(index: Int)
    func DeleteList(index: Int)
}

class ShoppingListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputTitle: UITextField!
    
    var list = [ShoppingList]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func addListButton(_ sender: Any) {
        list.append(ShoppingList(title: inputTitle.text ?? ""))
        
        inputTitle.text = nil
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return list.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ListCell else { return UITableViewCell() }
        
        cell.delegate = self
        cell.index = indexPath.row
        cell.title.text = list[indexPath.row].title
        cell.isChecked = list[indexPath.row].isChecked
        
        if cell.isChecked {
            cell.title.layer.opacity = 0.3
            cell.check.layer.opacity = 0.3
        }
        else {
            cell.title.layer.opacity = 1
            cell.check.layer.opacity = 1
        }
        
        return cell
    }
}

extension ShoppingListVC: ListButtonDelegate {
    func CheckList(index: Int) {
        
        if list[index].isChecked {
            list[index].isChecked = false
        }
        else {
            list[index].isChecked = true
        }
        
        tableView.reloadData()
    }
    
    func DeleteList(index: Int) {
        list.remove(at: index)
        
        tableView.reloadData()
    }
}

// 장바구니 리스트 모델
struct ShoppingList {
    var title: String
    var isChecked: Bool = false
    
    init(title: String, isChecked: Bool = false) {
        self.title = title
        self.isChecked = isChecked
    }
}

class ListCell: UITableViewCell {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var check: UIButton!
    @IBOutlet weak var delete: UIButton!
    var index: Int = 0
    var isChecked: Bool = false
    var delegate: ListButtonDelegate?
    
    @IBAction func CheckList(_ sender: Any) {
        self.delegate?.CheckList(index: index)
    }
    
    @IBAction func DeleteList(_ sender: Any) {
        self.delegate?.DeleteList(index: index)
    }
}
