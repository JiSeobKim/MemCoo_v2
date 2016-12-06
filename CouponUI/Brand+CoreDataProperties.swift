//
//  Brand+CoreDataProperties.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 06/12/2016.
//  Copyright © 2016 mino. All rights reserved.
//

import Foundation
import CoreData


extension Brand {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Brand> {
        return NSFetchRequest<Brand>(entityName: "Brand");
    }

    @NSManaged public var logo: NSObject?
    @NSManaged public var title: String?
    @NSManaged public var toCoupon: Coupon?
    @NSManaged public var toMembership: Membership?

}
