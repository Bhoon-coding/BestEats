//
//  FoodModi.swift
//  Besteats
//
//  Created by BH on 2022/02/22.
//

import Foundation

struct Restaurants: Codable, Equatable {
    var restaurantName: String
    var favoriteMenus: [String]
    var menu: [Menus]
    
    static func == (lhs: Restaurants, rhs: Restaurants) -> Bool {
        return lhs.restaurantName == rhs.restaurantName && lhs.menu == rhs.menu
    }
    
    init(
        restaurantName: String,
        favoriteMenus: [String],
        menu: [Menus]
        ) {
        self.restaurantName = restaurantName
        self.favoriteMenus = favoriteMenus
        self.menu = menu
    }
}

struct Menus: Codable, Equatable {
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
