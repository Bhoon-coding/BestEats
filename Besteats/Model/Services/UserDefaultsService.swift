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
        
        if type == "like" {
            restaturant.likeMenus.append(addedMenu)
            
        } else if type == "curious" {
            restaturant.curiousMenus.append(addedMenu)
            
        } else {
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
        
        if type == "like" {
            restaurant.likeMenus.remove(at: menuIndex)
            
        } else if type == "curious" {
            restaurant.curiousMenus.remove(at: menuIndex)
            
        } else {
            restaurant.badMenus.remove(at: menuIndex)
        }
        
        restaurants[selectedIndex] = restaurant
        saveRestaurants(restaurants: restaurants)
        return restaurant
    }
    
    func updateFavoriteMenu(selectedRestaurant: Restaurant,
                     selectedRestauransIndex: Int,
                     selectedMenu: Menu,
                     menuIndex: Int) -> Restaurant {
        
        var restaurants = getRestaurants()
        var restaurant = selectedRestaurant
        var menus = selectedRestaurant.likeMenus
        var menu = selectedMenu

        menu.isFavorite = !menu.isFavorite
        menus[menuIndex] = menu
        restaurant.likeMenus = menus
        restaurants[selectedRestauransIndex] = restaurant
        saveRestaurants(restaurants: restaurants)
        
        return restaurant
    }
    
    func updateMenu(selectedRestaurant: Restaurant,
                    selectedRestauransIndex: Int,
                    prevType: String,
                    changeType: String,
                    editedMenu: Menu,
                    menuIndex: Int
                    ) {
        
        var restaurants = getRestaurants()
        var restaurant = selectedRestaurant
        var menus = selectedRestaurant.likeMenus
        var menu = editedMenu
        
        if prevType != changeType {
            
            if changeType == "like" {
                menus = selectedRestaurant.likeMenus
                menus.append(menu)
                restaurant.likeMenus = menus
                
            } else if changeType == "curious" {
                menus = selectedRestaurant.curiousMenus
                menus.append(menu)
                restaurant.curiousMenus = menus
                menu.isFavorite = false
                
            } else if changeType == "warning" {
                menus = selectedRestaurant.badMenus
                menus.append(menu)
                restaurant.badMenus = menus
                menu.isFavorite = false
            }
            
            if prevType == "like" {
                menus = selectedRestaurant.likeMenus
                menus.remove(at: menuIndex)
                restaurant.likeMenus = menus
            
            } else if prevType == "curious" {
                menus = selectedRestaurant.curiousMenus
                menus.remove(at: menuIndex)
                restaurant.curiousMenus = menus
                
            } else if prevType == "warning" {
                menus = selectedRestaurant.badMenus
                menus.remove(at: menuIndex)
                restaurant.badMenus = menus
            }
            
        }
        
        restaurants[selectedRestauransIndex] = restaurant
        saveRestaurants(restaurants: restaurants)
    }

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
