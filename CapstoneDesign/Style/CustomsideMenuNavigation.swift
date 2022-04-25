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
    
    /*override func viewWillDisappear(_ animated: Bool) {
        self.menuWidth = self.view.frame.width
    }*/
}
