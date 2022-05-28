//
//  CorrectFoodVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/20.
//

import UIKit
import Alamofire

class CorrectFoodVC: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = CorrectViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension CorrectFoodVC: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.counfOfFoods
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? CorrectCell else { return UITableViewCell() }
        
        cell.updateUI(viewModel.foods[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CorrectDetailVC") as? CorrectDetailVC else { return }
        
        viewModel.detailFood = viewModel.foods[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func CompleteButton(_ sender: Any) {
        viewModel.correctFoods() { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
    }
    
}

extension CorrectFoodVC {
    func setup() {
        viewModel.loadFoods()
    }
}
