//
//  Membership+CoreDataClass.swift
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

@objc(Membership)
public class Membership: NSManagedObject {
<<<<<<< HEAD
    
=======

>>>>>>> JoosungKim
    public override func awakeFromInsert() {
        super.awakeFromInsert()
        
        self.created = NSDate()
    }
<<<<<<< HEAD

=======
    
>>>>>>> JoosungKim
}
