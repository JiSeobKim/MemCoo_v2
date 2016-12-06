//
//  Membership+CoreDataClass.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 06/12/2016.
//  Copyright © 2016 mino. All rights reserved.
//

import Foundation
import CoreData

@objc(Membership)
public class Membership: NSManagedObject {
    
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }

}
