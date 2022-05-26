//
//  SetAddFoodVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/12.
//

import UIKit
import Alamofire

class SetAddFoodVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = AddViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension SetAddFoodVC {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numOfFoods
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as? AddCell else { return UITableViewCell() }
        
        cell.updateUI(viewModel.foods[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "SetDetailFoodVC") as? SetDetailFoodVC else { return }
        
        viewModel.detailFood = viewModel.foods[indexPath.row]
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

extension SetAddFoodVC {
    func setup() {
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = SetBackButton()
    }
    
    @IBAction func CompleteButton(_ sender: Any) {
        if viewModel.count != viewModel.foods.count {
            present(Alert("식재료 정보를 모두 입력해 주세요."), animated: true)
        } else {
            viewModel.addFood { [weak self] in
                self?.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
}
