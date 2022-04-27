//
//  ShowFriendVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/19.
//  ss

import UIKit

class ShowFriendVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let foodModel = FriendsFoodModel.sharedFriendsFoodModel
    var friendName: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = SetBackButton()
        self.navigationItem.title = friendName
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        foodModel.FoodInfoList.removeAll()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return foodModel.countOfFoodList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FriendsFoodCell else { return UICollectionViewCell() }
        
        let foodInfo = foodModel.foodInfo(at: indexPath.item)
        cell.FoodUpdate(info: foodInfo)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showFriendsFood", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showFriendsFood" {
            let vc = segue.destination as? DetailFriendsFoodVC
            if let indexPath = collectionView.indexPathsForSelectedItems {
                let row = indexPath[0].row
                let foodInfo = foodModel.foodInfo(at: row)
                vc?.foodInfo = foodInfo
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 20
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1
    }
     
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width / 3 - 1 ///  3등분하여 배치, 옆 간격이 1이므로 1을 빼줌

        let size = CGSize(width: width, height: width)
 
        return size
    }
    
    
}

class FriendsFoodCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    var foodName: String!
    var foodPDate: String!
    var foodEDate: String!
    var foodMemo: String!
    
    func FoodUpdate(info: FriendFoodInfo) {
        imgView.image = info.image
        nameLabel.text = info.foodName
        foodName = info.foodName
        foodPDate = info.foodPurchaseDate
        foodEDate = info.foodExpirationDate
        foodMemo = info.foodMemo
    }
}
