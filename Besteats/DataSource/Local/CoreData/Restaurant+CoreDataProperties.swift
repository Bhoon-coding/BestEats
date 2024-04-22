//
//  Restaurant+CoreDataProperties.swift
//  Besteats
//
//  Created by BH on 2024/04/17.
//
//

import Foundation
import CoreData


extension Restaurant {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Restaurant> {
        return NSFetchRequest<Restaurant>(entityName: "Restaurant")
    }

    @NSManaged public var id: UUID
    @NSManaged public var name: String
    @NSManaged public var menus: NSSet

}

// MARK: Generated accessors for menus
extension Restaurant {

    @objc(addMenusObject:)
    @NSManaged public func addToMenus(_ value: Menu)

    @objc(removeMenusObject:)
    @NSManaged public func removeFromMenus(_ value: Menu)

    @objc(addMenus:)
    @NSManaged public func addToMenus(_ values: NSSet)

    @objc(removeMenus:)
    @NSManaged public func removeFromMenus(_ values: NSSet)

}

extension Restaurant : Identifiable {

}
