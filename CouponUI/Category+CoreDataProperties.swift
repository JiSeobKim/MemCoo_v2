//
//  Category+CoreDataProperties.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 08/02/2017.
//  Copyright © 2017 mino. All rights reserved.
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category");
    }

    @NSManaged public var title: String?
    @NSManaged public var toCoupon: NSSet?
    @NSManaged public var toImage: Image?
    @NSManaged public var toMembership: NSSet?

}

// MARK: Generated accessors for toCoupon
extension Category {

    @objc(addToCouponObject:)
    @NSManaged public func addToToCoupon(_ value: Coupon)

    @objc(removeToCouponObject:)
    @NSManaged public func removeFromToCoupon(_ value: Coupon)

    @objc(addToCoupon:)
    @NSManaged public func addToToCoupon(_ values: NSSet)

    @objc(removeToCoupon:)
    @NSManaged public func removeFromToCoupon(_ values: NSSet)

}

// MARK: Generated accessors for toMembership
extension Category {

    @objc(addToMembershipObject:)
    @NSManaged public func addToToMembership(_ value: Membership)

    @objc(removeToMembershipObject:)
    @NSManaged public func removeFromToMembership(_ value: Membership)

    @objc(addToMembership:)
    @NSManaged public func addToToMembership(_ values: NSSet)

    @objc(removeToMembership:)
    @NSManaged public func removeFromToMembership(_ values: NSSet)

}
