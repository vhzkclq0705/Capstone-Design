//
//  CustomsideMenuNavigation.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/01/22.
//

import UIKit
import SideMenu

class CustomsideMenuNavigation: SideMenuNavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.menuWidth = self.view.frame.width * 0.7
        self.leftSide = true
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
