//
//  SideMenuVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/01/22.
//

import UIKit

class MainVC: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    let viewModel = ImageViewModel()
    // DataSource
    // 몇 개의 셀을 보여줄 것인지
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // return 셀의 개수
        return viewModel.countOfImageList
    }
    
    // 셀을 어떻게 표현할 것인지
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? foodCell else { return UICollectionViewCell() }
        
        let imageInfo = viewModel.imageInfo(at: indexPath.item) // indexPath.item을 기준으로 뷰모델에서 ImageInfo 가져옴
        cell.update(info: imageInfo) // 해당 셀을 업데이트
        
        
        return cell
    }
    
    // Delegate
    // 셀 선택 시
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("--> \(indexPath.item)")
        performSegue(withIdentifier: "showDetail", sender: nil)
        
    }
    
    // DelegateFlowLayout
    // cell 디자인
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
    
    @IBAction func addFood(_ sender: Any) {
        
    }
    
    @IBAction func deleteFood(_ sender: Any) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    

}

// 컬렉션뷰 커스텀 셀
class foodCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func update(info: ImageInfo) {
            imgView.image = info.image
            nameLabel.text = info.name
        }
    
    func FoodUpdate(info: FoodInfo) {
        imgView.image = info.image
        nameLabel.text = info.foodName
    }
}


