//
//  FoodModi.swift
//  Besteats
//
//  Created by BH on 2022/02/22.
//

import Foundation

struct FoodModiModel: Codable {
    let restaurantName: String
    let menu: String
    let oneLiner: String
    let type: String
    
    init(restaurantName: String,
         menu: String,
         oneLiner: String,
         type: String) {
        self.restaurantName = restaurantName
        self.menu = menu
        self.oneLiner = oneLiner
        self.type = type
    }
}
