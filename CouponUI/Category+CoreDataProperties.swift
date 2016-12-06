//
//  Category+CoreDataProperties.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 06/12/2016.
//  Copyright © 2016 mino. All rights reserved.
//

import Foundation
import CoreData


extension Category {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Category> {
        return NSFetchRequest<Category>(entityName: "Category");
    }

    @NSManaged public var symbol: NSObject?
    @NSManaged public var title: String?
    @NSManaged public var toCoupon: Coupon?
    @NSManaged public var toMembership: Membership?

}
