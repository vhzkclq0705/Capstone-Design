//
//  RecipeVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/27.
//

import UIKit
import SwiftSoup

class RecipeVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var collectionVeiwY: NSLayoutConstraint!
    
    let viewModel = RecipeViewModel()
    var isDetail = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
    }
    
}

extension RecipeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.numOfRecipes
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RecipeCell else { return UICollectionViewCell() }
        
        cell.updateUI(viewModel.recipes[indexPath.row])
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "gotoWeb", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "gotoWeb" {
            let vc = segue.destination as? WebKitVC
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                vc?.link = viewModel.recipes[indexPath.row].link
            }
        }
    }
}

extension RecipeVC {
    func setup() {
        viewModel.crawling(isDetail)
        
        self.collectionView.collectionViewLayout = createLayout()
        
        if !isDetail {
            collectionVeiwY.constant -= 40
        }
    }
    
    func createLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 5, bottom: 2, right: 5)
        
        let width = collectionView.frame.width
        layout.itemSize = CGSize(width: width, height: width / 3)
        
        return layout
    }
    
    @IBAction func backButton(_ sender: Any) {
        dismiss(animated: true)
    }
}
