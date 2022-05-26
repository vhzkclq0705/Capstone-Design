//
//  Crawling.swift
//  CapstoneDesign
//
//  Created by 권오준 on 2022/05/22.
//

import Foundation
import UIKit
import SwiftSoup

class Crawling {
    
    private init() {}
    
    static func getDocument(_ names: [String], completion: @escaping(Document) -> Void) {
        var components = URLComponents(string: Address.crawling.address)!
        let search = names.joined(separator: " ")
        let queryItem = URLQueryItem(name: "q", value: search)
        components.queryItems = [queryItem]
        
        let html = try! String(contentsOf: components.url!, encoding: .utf8)
        let doc: Document = try! SwiftSoup.parse(html)
        
        completion(doc)
    }
    
    static func getTitles(_ doc: Document) -> [String] {
        let elements: Elements = try! doc.select(".rcp_m_list2").select(".common_sp_list_li").select(".common_sp_caption").select(".common_sp_caption_tit")
        
        let titles = elements.map { try! $0.text() }

        return titles
    }
    
    static func getImageURLs(_ doc: Document) -> [URL] {
        let elements: Elements = try! doc.select(".rcp_m_list2").select(".common_sp_list_li").select(".common_sp_thumb").select("img")
        
        let urls = elements.map { try! $0.attr("src") }
        let filter = urls.filter{
            return $0 != "https://recipe1.ezmember.co.kr/img/icon_vod.png"
        }
        
        let imageURLs = filter.map { URL(string: $0)! }
        
        return imageURLs
    }
    
    static func getLinks(_ doc: Document) -> [String] {
        let elements: Elements = try! doc.select(".rcp_m_list2").select(".common_sp_list_li").select(".common_sp_thumb").select("a")
        
        let links = elements.map { try! $0.attr("href") }
        
        return links
    }
}
