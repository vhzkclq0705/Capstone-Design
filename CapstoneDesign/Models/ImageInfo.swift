//
//  ImageInfo.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/21.
//

import Foundation

// ML 연동용
struct ImageInfo: Codable {
    var class_name = [String]()
    
    init() {
        self.class_name = []
    }
}
