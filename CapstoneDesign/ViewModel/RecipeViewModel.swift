//
//  RecipeViewModel.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/23.
//

import Foundation
import UIKit
import SwiftSoup

class RecipeViewModel {
    
    var recipes = [Recipe]()
    
    var numOfRecipes: Int {
        return recipes.count
    }
    
    
    func createReicpe(title: String, imageURL: URL, link: String) -> Recipe {
        return Recipe(title: title, imageURL: imageURL, link: link)
    }
    
    func crawling(_ isDetail: Bool) {
        var doc = Document("")
        let names = FoodManager.shared.foods.map { $0.name }
        
        Crawling.getDocument(names) { [weak self] data in
            doc = data
            let titles = Crawling.getTitles(doc)
            let imageURLs = Crawling.getImageURLs(doc)
            let links = Crawling.getLinks(doc)
            
            for i in 0...titles.count - 1 {
                let recipe = self?.createReicpe(title: titles[i], imageURL: imageURLs[i], link: links[i])
                self?.recipes.append(recipe!)
            }
        }
    }
}
