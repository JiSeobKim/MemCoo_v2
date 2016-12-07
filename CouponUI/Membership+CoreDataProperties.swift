//
//  Membership+CoreDataProperties.swift
//  MemebershipCoupon
//
<<<<<<< HEAD
//  Created by Joosung Kim on 06/12/2016.
=======
//  Created by Joosung Kim on 07/12/2016.
>>>>>>> JoosungKim
//  Copyright © 2016 mino. All rights reserved.
//

import Foundation
import CoreData


extension Membership {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Membership> {
        return NSFetchRequest<Membership>(entityName: "Membership");
    }

<<<<<<< HEAD
    @NSManaged public var barcode: NSObject?
    @NSManaged public var barcodeImg: NSObject?
    @NSManaged public var created: NSObject?
    @NSManaged public var favorite: NSObject?
    @NSManaged public var toBrand: Brand?
    @NSManaged public var toCategory: Category?
=======
    @NSManaged public var barcode: String?
    @NSManaged public var created: NSDate?
    @NSManaged public var favorite: Bool
    @NSManaged public var toBrand: Brand?
    @NSManaged public var toCategory: NSSet?
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
>>>>>>> JoosungKim

}
