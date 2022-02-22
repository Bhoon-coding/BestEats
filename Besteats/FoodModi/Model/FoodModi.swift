//
//  FoodModi.swift
//  Besteats
//
//  Created by BH on 2022/02/22.
//

import Foundation

struct FoodModiModel {
    let restaurantName: String
    let menu: String
    let oneLiner: String
    let rate: [String]
    
    init(restaurantName: String, menu: String, oneLiner: String, rate: [String]) {
        self.restaurantName = restaurantName
        self.menu = menu
        self.oneLiner = oneLiner
        self.rate = rate
    }
}
