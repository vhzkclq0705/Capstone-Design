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
        textView.font = UIFont(name: "TmonMonsoriBlack", size: 30)
        
    }
    
    @IBAction func BackButton(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

}

