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
    func updateRestaurant(selectedRestaurant: Restaurants,
                          selectedIndex: Int) {
        
        var restaurants = getRestaurants()
        
        restaurants[selectedIndex] = selectedRestaurant
    }
    
    func addMenu(selectedRestaurant: Restaurants,
                 selectedIndex: Int,
                 addedMenu: Menus) {
        
        var restaurants = getRestaurants()
        var restaturant = selectedRestaurant
        
        restaturant.menu.append(addedMenu)
        restaurants[selectedIndex] = restaturant
        saveRestaurants(restaurants: restaurants)
    }
    
    func deleteMenu(selectedRestaurant: Restaurants,
                    selectedIndex: Int,
                    menu: Menus
                    ) -> Restaurants {
        
        var restaurants = getRestaurants()
        var restaurant = selectedRestaurant
        let filteredMenu = restaurant.menu.filter { $0.id != menu.id }
        restaurant.menu = filteredMenu
        restaurants[selectedIndex] = restaurant
        saveRestaurants(restaurants: restaurants)
        return restaurant
    }
    
    func updateMenus(selectedRestaurant: Restaurants,
                     selectedIndex: Int,
                     selectedMenu: Menus,
                     menuIndex: Int) -> Restaurants {
        
        var restaurants = getRestaurants()
        var restaurant = selectedRestaurant
        var menus = selectedRestaurant.menu
        var menu = selectedMenu

        if menu.isFavorite {
            menu.isFavorite = false
            restaurant.favoriteMenus.remove(at: menuIndex)
            
        } else {
            menu.isFavorite = true
            restaurant.favoriteMenus.append(menu.menu!)
            
        }
        menus[menuIndex] = menu
        restaurant.menu = menus
        restaurants[selectedIndex] = restaurant
        
        saveRestaurants(restaurants: restaurants)
        return restaurant
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
