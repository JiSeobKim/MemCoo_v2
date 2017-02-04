//
//  Coupon+CoreDataClass.swift
//  
//
//  Created by Joosung Kim on 31/01/2017.
//
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
