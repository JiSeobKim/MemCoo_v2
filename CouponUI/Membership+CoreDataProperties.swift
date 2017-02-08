//
//  Membership+CoreDataProperties.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 08/02/2017.
//  Copyright © 2017 mino. All rights reserved.
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
    @NSManaged public var title: String?
    @NSManaged public var toBrand: Brand?
    @NSManaged public var toCategory: NSSet?
    @NSManaged public var toFavorite: Favorite?
    @NSManaged public var toImage: Image?

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
