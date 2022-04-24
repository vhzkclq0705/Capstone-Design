//
//  SideMenuVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/01/22.
//

import UIKit

class MainVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sideMenuButton: ButtonStyle!
    @IBOutlet weak var correctButton: ButtonStyle!
    @IBOutlet weak var completeDeleteButton: ButtonStyle!
    @IBOutlet weak var deleteCancelButton: UIButton!
    @IBOutlet weak var recommendButton: ButtonStyle!
    @IBOutlet weak var addDeleteButtons: UIStackView!
    @IBOutlet weak var deleteStackView: UIStackView!
    @IBOutlet weak var clearView: UIView!
    
    let userInfo = UserInfo.sharedUserInfo
    var foodModel = FoodModel.sharedFoodModel
    var deleteFoodIndexList = [Int]()
    var isDeleting = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.topItem?.backBarButtonItem = SetBackButton()

        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        collectionView.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        view.layer.opacity = 1
    }
}

extension MainVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if foodModel.countOfFoodList == 0 {
            clearView.isHidden = false
        }
        return foodModel.countOfFoodList
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? FoodCell else { return UICollectionViewCell() }
        
        let foodInfo = foodModel.foodInfo(at: indexPath.item)
        cell.FoodUpdate(info: foodInfo)
        
        // 삭제 관련
        if isDeleting {
            cell.checkView.isHidden = false
            cell.checkView.backgroundColor = UIColor.lightGray
        }
        else {
            cell.checkView.isHidden = true
            cell.checkImg.isHidden = true
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("--> \(indexPath.item)")
        
        guard let cell = collectionView.cellForItem(at: indexPath) as? FoodCell else { return }
        
        if isDeleting {
            if let index = deleteFoodIndexList.firstIndex(of: indexPath.item) {
                cell.checkImg.isHidden = true
                cell.checkView.backgroundColor = UIColor.lightGray
                deleteFoodIndexList.remove(at: index)
                print(deleteFoodIndexList)
            }
            else {
                cell.checkImg.isHidden = false
                cell.checkView.backgroundColor = UIColor.init(named: "lightSky")
                deleteFoodIndexList.append(indexPath.item)
                deleteFoodIndexList = Array(Set(deleteFoodIndexList))
                deleteFoodIndexList.sort()
                print(deleteFoodIndexList)
            }
            completeDeleteButton.titleLabel?.text = "삭제하기(\(deleteFoodIndexList.count))"
        }
        else {
            performSegue(withIdentifier: "showDetailFood", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailFood" {
            let vc = segue.destination as? DetailFoodVC
            if let indexPath = collectionView.indexPathsForSelectedItems {
                let row = indexPath[0].row
                let foodInfo = foodModel.foodInfo(at: row)
                vc?.foodInfo = foodInfo
            }
        }
    }
}

extension MainVC: UICollectionViewDelegateFlowLayout {
    // 위 아래 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 20
    }

    // 옆 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 1
    }
     
    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {

        let width = collectionView.frame.width / 3 - 1 ///  3등분하여 배치, 옆 간격이 1이므로 1을 빼줌

        let size = CGSize(width: width, height: width)
 
        return size
    }
}

extension MainVC {  // Action funcs + Custom funcs
    @IBAction func CorrectButton(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "CorrectFoodVC") as? CorrectFoodVC else { return }
        
        vc.delegate = self
        vc.foodModel = foodModel
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func RecommendButton(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "RecommendVC") as? RecommendVC else { return }
        vc.foodName = foodModel.FoodInfoList.map { $0.foodName! }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func deleteFood(_ sender: Any) {
        DeletingState()
    }
    
    @IBAction func CancelDeleteButton(_ sender: Any) {
        DeletingState()
    }
    
    @IBAction func FinishDeleteButton(_ sender: Any) {
        if deleteFoodIndexList.count != 0 {
            for i in 0...deleteFoodIndexList.count - 1 {
                foodModel.FoodInfoList.remove(at: deleteFoodIndexList[i] - i)
            }
            print(foodModel.FoodInfoList)
            deleteFoodIndexList.removeAll()
        }
        DeletingState()
        // 서버에 바뀐 모델 전송 추가
    }
    
    func DeletingState() {
        if isDeleting {
            isDeleting = false
            self.navigationItem.title = "내 식재료"
            recommendButton.isHidden = false
            addDeleteButtons.isHidden = false
            correctButton.isHidden = false
            sideMenuButton.isHidden = false
            deleteStackView.isHidden = true
        }
        else {
            isDeleting = true
            self.navigationItem.title = "재료 삭제"
            recommendButton.isHidden = true
            addDeleteButtons.isHidden = true
            correctButton.isHidden = true
            sideMenuButton.isHidden = true
            deleteStackView.isHidden = false
        }
        collectionView.reloadData()
    }
}

// 컬렉션뷰 커스텀 셀
class FoodCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    // 삭제 체크 표시
    @IBOutlet weak var checkView: ViewStyle!
    @IBOutlet weak var checkImg: UIImageView!
    
    var foodName: String!
    var foodPDate: String!
    var foodEDate: String!
    var foodMemo: String!
    
    func FoodUpdate(info: FoodInfo) {
        imgView.image = info.image
        nameLabel.text = info.foodName
        foodName = info.foodName
        foodPDate = info.foodPurchaseDate
        foodEDate = info.foodExpirationDate
        foodMemo = info.foodMemo
    }
}

extension MainVC: CompleteCorrectDelegate {
    func didCorrectFoodDone(_ controller: CorrectFoodVC, data: FoodModel) {
        foodModel = data
        collectionView.reloadData()
    }
}