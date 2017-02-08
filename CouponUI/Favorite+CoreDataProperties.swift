//
//  Favorite+CoreDataProperties.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 08/02/2017.
//  Copyright © 2017 mino. All rights reserved.
//

import Foundation
import CoreData


extension Favorite {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Favorite> {
        return NSFetchRequest<Favorite>(entityName: "Favorite");
    }

    @NSManaged public var created: NSDate?
    @NSManaged public var index: Int32
    @NSManaged public var isCoupon: Bool
    @NSManaged public var isMembership: Bool
    @NSManaged public var toCoupon: Coupon?
    @NSManaged public var toMembership: Membership?

}
