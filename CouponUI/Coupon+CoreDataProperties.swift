//
//  Coupon+CoreDataProperties.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 06/12/2016.
//  Copyright © 2016 mino. All rights reserved.
//

import Foundation
import CoreData


extension Coupon {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Coupon> {
        return NSFetchRequest<Coupon>(entityName: "Coupon");
    }

    @NSManaged public var barcode: String?
    @NSManaged public var barcodeImg: NSObject?
    @NSManaged public var created: NSDate?
    @NSManaged public var expireDate: NSDate?
    @NSManaged public var favorite: Bool
    @NSManaged public var image: NSObject?
    @NSManaged public var originalText: String?
    @NSManaged public var title: String?
    @NSManaged public var toBrand: Brand?
    @NSManaged public var toCategory: Category?

}
