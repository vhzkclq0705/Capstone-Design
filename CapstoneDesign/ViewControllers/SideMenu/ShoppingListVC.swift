//
//  ShoppingListVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/18.
//

import UIKit

class ShoppingListVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var inputTitle: UITextField!
    
    let viewModel = ShoppingViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension ShoppingListVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfTodos
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? ShoppingCell else { return UITableViewCell() }
        
        let todo = viewModel.todos[indexPath.row]
        cell.updateUI(todo)
        cell.deleteButtonHandler = { [weak self] in
            self?.viewModel.deleteTodo(todo)
            self?.tableView.reloadData()
        }
        
        return cell
    }
}

extension ShoppingListVC {
    func setup() {
        viewModel.loadTodos()
    }
    
    @IBAction func addListButton(_ sender: Any) {
        guard let term = inputTitle.text, term.isEmpty == false else { return }
        viewModel.addTodo(term)
        
        inputTitle.text = ""
        tableView.reloadData()
    }
}
