//
//  Menu+CoreDataProperties.swift
//  Besteats
//
//  Created by BH on 2024/04/17.
//
//

import Foundation
import CoreData


extension Menu {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Menu> {
        return NSFetchRequest<Menu>(entityName: "Menu")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var isFavorite: Bool
    @NSManaged public var name: String?
    @NSManaged public var oneLiner: String?
    @NSManaged public var type: String?
    @NSManaged public var restaurant: Restaurant?

}

extension Menu : Identifiable {

}
