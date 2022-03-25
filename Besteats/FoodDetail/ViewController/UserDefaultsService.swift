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
    func updateRestaurant(selectedRestaurant: Restaurants, selectedIndex: Int) {
        var restaurants = getRestaurants()
        
        restaurants[selectedIndex] = selectedRestaurant
        
        dump(restaurants)
        
    }
    
    func addMenu(selectedRestaurant: Restaurants, selectedIndex: Int, addedMenu: Menus) {
        // [x] 파라미터 (선택된맛집, 선택된idx, 메뉴)
        // [x] 전체 맛집 데이터 호출
        var restaurants = getRestaurants()
        var restaturant = selectedRestaurant
        // [x] 메뉴 추가 -> 선택된 맛집의 [메뉴]에 메뉴추가
        restaturant.menu.append(addedMenu)
        // [x] 전체 맛집[idx] = 선택된 맛집
        restaurants[selectedIndex] = restaturant
        // save맛집
        saveRestaurants(restaurants: restaurants)
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
        defaults.set(try? PropertyListEncoder().encode(restaurants),
                     forKey: "restaurantsData")
    }
    
}
