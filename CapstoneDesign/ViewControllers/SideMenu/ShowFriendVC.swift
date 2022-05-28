//
//  ShowFriendVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/19.
//  ss

import UIKit

class ShowFriendVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let viewModel = FriendsViewModel.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
}

extension ShowFriendVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.numOfFoods
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FriendsFoodCell else { return UICollectionViewCell() }
        
        cell.updateUI(viewModel.foods[indexPath.item])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        viewModel.detail = viewModel.foods[indexPath.item]
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "detailFoodVC") as? DetailFoodVC else { return }
        vc.food = viewModel.detail
        
        self.present(vc, animated: true)
    }
}

extension ShowFriendVC {
    func setup() {
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = SetBackButton()
        self.navigationItem.title = viewModel.email
        
        self.collectionView.collectionViewLayout = createLayout()
    }
    
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 10, right: 5)
        
        let width = (view.bounds.width - 30) / 3
        layout.itemSize = CGSize(width: width, height: width)
        
        return layout
    }
}
