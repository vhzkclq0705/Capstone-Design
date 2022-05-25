//
//  Alert.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/23.
//

import Foundation
import UIKit

func Alert(_ title: String) -> UIAlertController {
    let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
    let defaultAction = UIAlertAction(title: "확인", style: .cancel)
    
    alert.addAction(defaultAction)
    
    return alert
}
