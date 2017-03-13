//
//  Favorite+CoreDataClass.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 08/02/2017.
//  Copyright © 2017 mino. All rights reserved.
//

import Foundation
import CoreData

@objc(Favorite)
public class Favorite: NSManagedObject {
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
}
