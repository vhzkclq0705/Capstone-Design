//
//  RecipeViewModel.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/23.
//

import Foundation
import UIKit

class RecipeViewModel {
    
    var recipes = [Recipe]()
    
    var numOfRecipes: Int {
        return recipes.count
    }
    
    func crawling(_ names: [String]) {
        let doc = Crawling.getDocument(names)
        let titles = Crawling.getTitles(doc)
        let imageURLs = Crawling.getImageURLs(doc)
        let links = Crawling.getLinks(doc)
        
        for i in 0...titles.count {
            recipes[i].title = titles[i]
            recipes[i].imageURL = imageURLs[i]
            recipes[i].link = links[i]
        }
    }
}
