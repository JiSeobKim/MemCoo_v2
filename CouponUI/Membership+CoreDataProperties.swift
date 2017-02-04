//
//  Membership+CoreDataProperties.swift
//  
//
//  Created by Joosung Kim on 31/01/2017.
//
//

import Foundation
import CoreData


extension Membership {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Membership> {
        return NSFetchRequest<Membership>(entityName: "Membership");
    }

    @NSManaged public var barcode: String?
    @NSManaged public var created: NSDate?
    @NSManaged public var favorite: Bool
    @NSManaged public var isFavorite: Bool
    @NSManaged public var toBrand: Brand?
    @NSManaged public var toCategory: NSSet?
    @NSManaged public var toImage: Image?
    @NSManaged public var toFavorite: Favorite?

}

// MARK: Generated accessors for toCategory
extension Membership {

    @objc(addToCategoryObject:)
    @NSManaged public func addToToCategory(_ value: Category)

    @objc(removeToCategoryObject:)
    @NSManaged public func removeFromToCategory(_ value: Category)

    @objc(addToCategory:)
    @NSManaged public func addToToCategory(_ values: NSSet)

    @objc(removeToCategory:)
    @NSManaged public func removeFromToCategory(_ values: NSSet)

}
