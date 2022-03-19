//
//  FoodModi.swift
//  Besteats
//
//  Created by BH on 2022/02/22.
//

import Foundation

struct Restaurants: Codable {
    var restaurantName: String
    var menu: [Menus]
    
    init(
        restaurantName: String,
        menu: [Menus]
        ) {
        self.restaurantName = restaurantName
        self.menu = menu
    }
}

struct Menus: Codable {
    var menu: String
    var oneLiner: String
    var type: String
    
    init(
        menu: String,
        oneLiner: String,
        type:String
    ) {
        self.menu = menu
        self.oneLiner = oneLiner
        self.type = type
    }
}
