//
//  AddSelectVC.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/03/08.
//

import UIKit

class AddSelectVC: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView.textColor = UIColor.white
        textView.text = "재료를 추가할 방법을 \n 선택하세요."
        textView.font = UIFont(name: "TmonMonsoriBlack", size: 30)
    }
    
    @IBAction func useCamera(_ sender: Any) {

        guard let vc = self.storyboard?.instantiateViewController(withIdentifier: "CameraVC") as? CameraVC else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
