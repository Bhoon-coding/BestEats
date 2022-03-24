//
//  UserDefaultsService.swift
//  Besteats
//
//  Created by BH on 2022/03/23.
//

import Foundation

struct UserDefaultsManager {
    
    // MARK: Properties
    static let shared = UserDefaultsManager()
    let defaults = UserDefaults.standard
    
    
    // MARK: Methods
    func updateRestaurants(selectedRestaurant: Restaurants ,selectedIdx: Int) {
        var restaurants = getRestaurants()
        
        restaurants[selectedIdx] = selectedRestaurant
        
        dump(restaurants)
        
    }
//    func updateRestaurants(newRestaurant: Restaurants) {
//        var restaurants = getRestaurants()
//        var newRestaurantIndex = -1
//
//        for (index, restaurant) in restaurants.enumerated() {
//            if restaurant == newRestaurant {
//                newRestaurantIndex = index
//            }
//        }
//
//        if newRestaurantIndex == -1 {
//            print("바꿀가게가 없어")
//            return
//        }
//
//        restaurants[newRestaurantIndex] = newRestaurant
//        saveRestaurants(restaurants: restaurants)
//    }

    func getRestaurants() -> [Restaurants] {
        guard let getRsEncodeData = defaults.value(forKey: "restaurantsData") as? Data else {
            return []
        }
        
        let restaurantData = try! PropertyListDecoder().decode([Restaurants].self,
                                                               from: getRsEncodeData)
        return restaurantData
    }

    func saveRestaurants(restaurants: [Restaurants]) {
        defaults.set(try? PropertyListEncoder().encode(restaurants), forKey: "restaurantsData")
    }
}
