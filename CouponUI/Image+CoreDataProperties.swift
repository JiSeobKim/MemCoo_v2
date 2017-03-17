//
//  Image+CoreDataProperties.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 07/12/2016.
//  Copyright © 2016 mino. All rights reserved.
//  This file was automatically generated and should not be edited.
//

import Foundation
import CoreData


extension Image {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Image> {
        return NSFetchRequest<Image>(entityName: "Image");
    }

    @NSManaged public var image: NSObject?
    @NSManaged public var toCoupon: Coupon?
    @NSManaged public var toBrand: Brand?
    @NSManaged public var toCategory: Category?
    @NSManaged public var toMembership: Membership?

}
