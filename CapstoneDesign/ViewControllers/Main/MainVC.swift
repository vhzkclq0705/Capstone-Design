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
    
    let viewModel = FoodViewModel.shared
    var isDeleting = false

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        NotificationCenter.default.addObserver(self, selector: #selector(reciveNotification(_:)), name: Notification.Name.name, object: nil)
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
            viewModel.checkDeleteFood(indexPath.item)
            cell.updateDeleteUI()
        } else {
            performSegue(withIdentifier: "showDetailFood", sender: self)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showDetailFood" {
            let vc = segue.destination as? DetailFoodVC
            if let indexPath = collectionView.indexPathsForSelectedItems {
                let item = indexPath[0].item
                vc?.food = viewModel.foods[item]
            }
        }
    }
}


extension MainVC {  // Action funcs + Custom funcs
    func setup() {
        viewModel.loadFoods() { [weak self] in
            print("Load Successed")
            self?.collectionView.reloadData()
        }
        
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
        
        vc.delegate = self
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func RecommendButton(_ sender: Any) {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "RecommendVC") as? RecommendVC else { return }
        vc.foodName
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func deleteFood(_ sender: Any) {
        DeletingState()
    }
    
    @IBAction func CancelDeleteButton(_ sender: Any) {
        DeletingState()
    }
    
    @IBAction func FinishDeleteButton(_ sender: Any) {
//        if deleteFoodIndexList.count != 0 {
//            for i in 0...deleteFoodIndexList.count - 1 {
//                let delFoodInfo = ["id": foodModel.FoodInfoList[deleteFoodIndexList[i] - i].id]
//                self.parameters.append(delFoodInfo)
//                foodModel.FoodInfoList.remove(at: deleteFoodIndexList[i] - i)
//            }
//            deleteFoodIndexList.removeAll()
//        }
//        DelFoodPost()
//        DeletingState()
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
    
//    func DelFoodPost() {
//        let url = "http://3.38.150.193:3000/food/delFood"
//        var request = URLRequest(url: URL(string: url)!)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.timeoutInterval = 10
//
//        // httpBody 에 parameters 추가
//        do {
//            try request.httpBody = JSONSerialization.data(withJSONObject: self.parameters)
//        } catch {
//            print("http Body Error")
//        }
//
//        AF.request(request).responseJSON { (response) in
//            switch response.result {
//            case .success(let json):
//                if let jsonData = json as? NSDictionary {
//                    if let code = jsonData["code"] as? Int {
//                        if code == 200 {
//                            print("삭제 완료")
//                            self.parameters.removeAll()
//                        }
//                    }
//                }
//            case .failure(let error):
//                print("🚫 Alamofire Request Error\nCode:\(error._code), Message: \(error.errorDescription!)")
//            }
//        }
//    }
}

extension MainVC: CompleteCorrectDelegate {
    func didCorrectFoodDone(_ controller: CorrectFoodVC, data: FoodModel) {
        //foodModel = data
        collectionView.reloadData()
    }
}
