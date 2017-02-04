//
//  Membership+CoreDataClass.swift
//  
//
//  Created by Joosung Kim on 31/01/2017.
//
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
