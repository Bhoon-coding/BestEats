//
//  FoodModi.swift
//  Besteats
//
//  Created by BH on 2022/02/22.
//

import Foundation

struct Restaurant: Codable, Equatable {
    var restaurantName: String
    var menus: [Menu]
    
    static func == (lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.restaurantName == rhs.restaurantName && lhs.menus == rhs.menus
    }
    
    init(
        restaurantName: String,
        menus: [Menu]
        ) {
        self.restaurantName = restaurantName
        self.menus = menus
    }
}

struct Menu: Codable, Equatable {
    var id: Int
    var isFavorite: Bool
    var menu: String?
    var oneLiner: String
    var type: String
    
    init(
        id: Int,
        isFavorite: Bool,
        menu: String,
        oneLiner: String,
        type:String
    ) {
        self.id = id
        self.isFavorite = isFavorite
        self.menu = menu
        self.oneLiner = oneLiner
        self.type = type
    }
}
