//
//  SideMenuVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/01/22.
//

import UIKit
import Alamofire

class MainVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sideMenuButton: ButtonStyle!
    @IBOutlet weak var correctButton: ButtonStyle!
    @IBOutlet weak var completeDeleteButton: ButtonStyle!
    @IBOutlet weak var deleteCancelButton: UIButton!
    @IBOutlet weak var recommendButton: ButtonStyle!
    @IBOutlet weak var addDeleteButtons: UIStackView!
    @IBOutlet weak var deleteStackView: UIStackView!
    @IBOutlet weak var clearLabel: UILabel!
    
    let viewModel = MainViewModel.shared
    var isDeleting = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.loadFoods()
        collectionView.reloadData()
    }
    
}

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.countOfFoods
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MyFoodCell.identifier, for: indexPath) as? MyFoodCell else { return UICollectionViewCell() }
        
        cell.updateUI(viewModel.foods[indexPath.item])
        cell.isDeleting(isDeleting)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let cell = collectionView.cellForItem(at: indexPath) as? MyFoodCell else { return }
        
        if isDeleting {
            viewModel.checkDeleteFood(viewModel.foods[indexPath.item])
            cell.updateDeleteUI()
        } else {
            performSegue(withIdentifier: "showDetailFood", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailFood" {
            if let indexPath = collectionView.indexPathsForSelectedItems {
                viewModel.detailFood = viewModel.foods[indexPath[0].item]
            }
        }
    }
}

extension MainVC {  // Action funcs + Custom funcs
    func setup() {
        self.collectionView.register(UINib(nibName: "MyFoodCell", bundle: nil), forCellWithReuseIdentifier: MyFoodCell.identifier)
        self.collectionView.collectionViewLayout = createLayout()
        
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = SetBackButton()
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
        
        let width = (view.bounds.width - 30) / 3
        layout.itemSize = CGSize(width: width, height: width)
        
        return layout
    }
    
    @IBAction func CorrectButton(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CorrectFoodVC") as? CorrectFoodVC else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func RecommendButton(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "RecipeVC") as? RecipeVC else { return }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func deleteFood(_ sender: Any) {
        DeletingState()
    }
    
    @IBAction func CancelDeleteButton(_ sender: Any) {
        DeletingState()
    }
    
    @IBAction func FinishDeleteButton(_ sender: Any) {
        viewModel.deleteFoods()
        DeletingState()
    }
    
    func DeletingState() {
        isDeleting = !isDeleting
        recommendButton.isHidden = isDeleting
        addDeleteButtons.isHidden = isDeleting
        correctButton.isHidden = isDeleting
        sideMenuButton.isHidden = isDeleting
        deleteStackView.isHidden = !isDeleting
        
        let title = isDeleting ? "재료 삭제" : "내 식재료"
        self.navigationItem.title = title
        
        collectionView.reloadData()
    }
    
    @objc func reciveNotification(_ notification: Notification) {
        self.collectionView.reloadData()
    }
}
