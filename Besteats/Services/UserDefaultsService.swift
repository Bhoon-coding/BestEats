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
    func addRestaurant(restaurant: Restaurant) {
        
        var restaurants = getRestaurants()
        restaurants.append(restaurant)
        
        saveRestaurants(restaurants: restaurants)
    }
    
    func updateRestaurant(selectedRestaurant: Restaurant,
                          selectedIndex: Int) {
        
        var restaurants = getRestaurants()
        
        restaurants[selectedIndex] = selectedRestaurant
    }
    
    func addMenu(selectedRestaurant: Restaurant,
                 selectedIndex: Int,
                 type: String,
                 addedMenu: Menu) {
        
        var restaurants = getRestaurants()
        var restaturant = selectedRestaurant
        
        switch type {
        case "like":
            restaturant.likeMenus.append(addedMenu)
        case "curious":
            restaturant.curiousMenus.append(addedMenu)
        default:
            restaturant.badMenus.append(addedMenu)
        }
        restaurants[selectedIndex] = restaturant
        saveRestaurants(restaurants: restaurants)
    }
    
    func deleteMenu(selectedRestaurant: Restaurant,
                    selectedIndex: Int,
                    type: String,
                    menu: Menu,
                    menuIndex: Int
                    ) -> Restaurant {
        
        var restaurants = getRestaurants()
        var restaurant = selectedRestaurant
        switch type {
        case "like":
            restaurant.likeMenus.remove(at: menuIndex)
        case "curious":
            restaurant.curiousMenus.remove(at: menuIndex)
        default:
            restaurant.badMenus.remove(at: menuIndex)
        }
//        let filteredMenus = restaurant.menus.filter { $0.id != menu.id }
//        restaurant.menus = filteredMenus
        restaurants[selectedIndex] = restaurant
        saveRestaurants(restaurants: restaurants)
        return restaurant
    }
    
    func updateMenus(selectedRestaurant: Restaurant,
                     selectedRestauransIndex: Int,
                     selectedMenu: Menu,
                     menuIndex: Int) -> Restaurant {
        
        var restaurants = getRestaurants()
        var restaurant = selectedRestaurant
        var menus = selectedRestaurant.menus
        var menu = selectedMenu
//        dump(menu)
        
        menu.isFavorite = !menu.isFavorite
        print("selectedRestaurant:")
        dump(selectedRestaurant)
        print("selectedIndex:\(selectedRestauransIndex)")
        print("selectedMenu:")
        dump(selectedMenu)
        print("menuIndex: \(menuIndex)")
        menus[menuIndex] = menu
        restaurant.menus = menus
        restaurants[selectedRestauransIndex] = restaurant
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

    func getRestaurants() -> [Restaurant] {
        guard let getRestaurnatsEncodeData = defaults.value(forKey: "restaurantsData") as? Data else {
            return []
        }
        
        let restaurantsData = try! PropertyListDecoder().decode([Restaurant].self,
                                                               from: getRestaurnatsEncodeData)
        return restaurantsData
    }

    func saveRestaurants(restaurants: [Restaurant]) {
        defaults.set(try? PropertyListEncoder().encode(restaurants),
                     forKey: "restaurantsData")
    }
    
}
