//
//  RecipeVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/22.
//

import UIKit
import SwiftSoup

class RecipeVC: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var topView: UIView!
    
    var foodName: String!
    var imgList = [UIImage]()
    var titleList = [String]()
    var linkList = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        crawl()
    }
}

extension RecipeVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return titleList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? RecipeCell else { return UICollectionViewCell() }
        
        cell.title.text = titleList[indexPath.item]
        cell.imgView.image = imgList[indexPath.item]
        cell.layer.borderColor = UIColor.lightGray.cgColor
        cell.layer.borderWidth = 1
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showWeb", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showWeb" {
            let vc = segue.destination as? WebKitVC
            if let indexPath = collectionView.indexPathsForSelectedItems?.first {
                vc?.link = linkList[indexPath.row]
            }
        }
    }
}

extension RecipeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
            return 10
    }

    // 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
            return 2
    }
     
    // cell 사이즈( 옆 라인을 고려하여 설정 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = collectionView.frame.width ///  2등분하여 배치
        let size = CGSize(width: width, height: width / 3)
 
        return size
    }
}

extension RecipeVC {    // Action funcs + Custom funcs
    // 크롤링 함수
    func crawl() {
        do {
            var urlAddress = "https://www.10000recipe.com/recipe/list.html?q="
            if foodName == nil {
                print("error")
            }
            else {
                urlAddress += foodName
            }
            
            guard let url = urlAddress.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
            
            let html = try String(contentsOf: URL(string: url)!, encoding: .utf8)
            let doc: Document = try SwiftSoup.parse(html)
            
            let title: Elements = try doc.select(".rcp_m_list2").select(".common_sp_list_li").select(".common_sp_caption").select(".common_sp_caption_tit")
            let img: Elements = try doc.select(".rcp_m_list2").select(".common_sp_list_li").select(".common_sp_thumb").select("img")
            let link: Elements = try doc.select(".rcp_m_list2").select(".common_sp_list_li").select(".common_sp_thumb").select("a")
            
            for i in link {
                if linkList.count <= 30 {
                    linkList.append(try i.attr("href"))
                }
            }
            
            for i in img {
                let str = try i.attr("src")
                let startIdx: String.Index = str.index(str.startIndex, offsetBy: str.count - 3)
                let result = String(str[startIdx...])
                
                if result != "png" {
                    let url = URL(string: try i.attr("src"))
                    let data = try Data(contentsOf: url!)
                    if imgList.count <= 30 {
                        imgList.append(UIImage(data: data)!)
                    }
                }
            }
            
            for i in title {
                if titleList.count <= 30 {
                    titleList.append(try i.text())
                }
            }
            
        } catch Exception.Error(_, let message) {
            print(message)
        } catch {
            print("error")
        }
    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}

class RecipeCell: UICollectionViewCell {
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var title: UILabel!
    
}
