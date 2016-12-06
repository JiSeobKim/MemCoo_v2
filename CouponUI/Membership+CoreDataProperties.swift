//
//  Membership+CoreDataProperties.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 06/12/2016.
//  Copyright © 2016 mino. All rights reserved.
//

import Foundation
import CoreData


extension Membership {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Membership> {
        return NSFetchRequest<Membership>(entityName: "Membership");
    }

    @NSManaged public var barcode: NSObject?
    @NSManaged public var barcodeImg: NSObject?
    @NSManaged public var created: NSObject?
    @NSManaged public var favorite: NSObject?
    @NSManaged public var toBrand: Brand?
    @NSManaged public var toCategory: Category?

}
