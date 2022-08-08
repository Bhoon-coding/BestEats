//
//  FoodPhotoListEndPoint.swift
//  Besteats
//
//  Created by BH on 2022/08/08.
//

import Foundation

class FoodPhotoListEndPoint: EndPointType {
    
    var baseURL: String {
        return "https://api.unsplash.com"
    }
    var path: String {
        return "/search/photos"
    }
    
    var query: [URLQueryItem] {
        return [URLQueryItem(name: "client_id", value: apiKey),
                URLQueryItem(name: "query", value: "food")]
    }
    
    var apiKey: String {
        return Bundle.main.apiKey
    }
    
    var page: Int
    
    init(page: Int) {
        self.page = page
    }
    
    
}
