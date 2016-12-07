//
//  Coupon+CoreDataClass.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 07/12/2016.
//  Copyright © 2016 mino. All rights reserved.
//

import Foundation
import CoreData

@objc(Coupon)
public class Coupon: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }

}
