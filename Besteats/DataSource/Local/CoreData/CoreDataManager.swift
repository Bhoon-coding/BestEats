//
//  CoreDataManager.swift
//  Besteats
//
//  Created by BH on 2024/04/11.
//

import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    private init() { }
    
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Model")
        container.loadPersistentStores { storeDescription, error in
            if let error = error as NSError? {
                print("Unresolved error: \(error)")
            }
        }
        return container
    }()
    
    var context: NSManagedObjectContext {
        return self.persistentContainer.viewContext
    }
    
    func saveContext() {
        if context.hasChanges {
            do {
                try context.save()
            } catch let error {
                print(CoreDataError.saveError(error))
            }
        }
    }
    
    func fetchRestaurants() -> [NSManagedObject] {
        // TODO: [] entityName 접근방법 바꾸기 (string -> enum)
        let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "Restaurant")
        do {
            let result = try persistentContainer.viewContext.fetch(fetchRequest)
            return result
        } catch let error {
            print(CoreDataError.readError(error))
            return []
        }
    }
    
    func saveMenu(name: String, oneLiner: String, type: String, isFavorite: Bool) -> Menu {
        let newMenu = Menu(context: context)
        newMenu.id = UUID()
        newMenu.name = name
        newMenu.oneLiner = oneLiner
        newMenu.type = type
        newMenu.isFavorite = isFavorite
        saveContext()
        return newMenu
    }
    
    func saveRestaurant(name: String, menu: Menu) {
        let newRestaurant = Restaurant(context: context)
        newRestaurant.id = UUID()
        newRestaurant.name = name
        newRestaurant.addToMenus(menu)
        saveContext()
    }
    
    func fetchRestaurant() -> [Restaurant] {
        let request = Restaurant.fetchRequest()
        do {
            let result = try persistentContainer.viewContext.fetch(request)
            return result
        } catch let error {
            print("Couldn't fetch Restaurant")
            return []
        }
    }
    
    func updateRestaurant(at index: Int, name: String) {
        let restaurants = fetchRestaurant()
        restaurants[index].name = name
        saveContext()
    }
    
    func deleteRestaurant(with selectedId: UUID) {
        do {
            let fetchRequest = Restaurant.fetchRequest()
            let predicate = NSPredicate(format: "id == %@", selectedId as CVarArg)
            fetchRequest.predicate = predicate
            let results = try context.fetch(fetchRequest)
            if let restaurantToDelete = results.first {
                context.delete(restaurantToDelete)
                saveContext()
            }
        } catch let error {
            print("Error deleting restaurant: \(error.localizedDescription)")
        }
    }
    
//    @discardableResult
//    func saveRestaurant(with restaurant: Restaurant) -> Bool {
//        // TODO: [] entityName 접근방법 바꾸기 (string -> enum)
//        let entity = NSEntityDescription.entity(forEntityName: "Restaurant", in: self.context)
//        if let entity = entity {
//            let managedObject = NSManagedObject(entity: entity, insertInto: self.context)
//            // TODO: [] restaurant model 만들기
//            // TODO: [] key 접근방법 바꾸기 (string -> enum)
//            managedObject.setValue(restaurant.name, forKey: "name")
//            managedObject.setValue(restaurant.type, forKey: "type")
//            
//            do {
//                try self.context.save()
//                print("Restaurant saved: \(managedObject)")
//                return true
//            } catch let error {
//                print(#function, CoreDataError.saveError(error))
//            }
//        } else {
//            print(#function, "Failed to access entity")
//            return false
//        }
//        return false
//    }
    
    @discardableResult
    func delete(with object: NSManagedObject) -> Bool {
        self.context.delete(object)
        
        do {
            try self.context.save()
            return true
        } catch let error {
            print(#function, CoreDataError.deleteError(error))
            return false
        }
    }
}

