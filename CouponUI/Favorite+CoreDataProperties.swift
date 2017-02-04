//
//  Favorite+CoreDataProperties.swift
//  
//
//  Created by Joosung Kim on 31/01/2017.
//
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite");
    }

    @NSManaged public var isCoupon: Bool
    @NSManaged public var isMembership: Bool
    @NSManaged public var toCoupon: Coupon?
    @NSManaged public var toMembership: Membership?
    @NSManaged public var created: NSDate?
    @NSManaged public var index: Int32

}
