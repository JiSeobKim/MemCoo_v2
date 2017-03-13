//
//  Image+CoreDataProperties.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 08/02/2017.
//  Copyright © 2017 mino. All rights reserved.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image");
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toBrand: Brand?
    @NSManaged public var toCategory: Category?
    @NSManaged public var toCoupon: Coupon?
    @NSManaged public var toMembership: Membership?

}
