//
//  PersistentContainer.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 13/02/2017.
//  Copyright © 2017 mino. All rights reserved.
//

import CoreData

struct CoreDataServiceConsts {
    static let applicationGroupIdentifier = "group.minos"
//    static let applicationGroupIdentifier = "group.Jiseob"
//    static let applicationGroupIdentifier = "group.MembershipCoupon"
}

final class PersistentContainer: NSPersistentContainer {
    internal override class func defaultDirectoryURL() -> URL {
        var url = super.defaultDirectoryURL()
        if let newURL =
            FileManager.default.containerURL(
                forSecurityApplicationGroupIdentifier: CoreDataServiceConsts.applicationGroupIdentifier) {
            url = newURL
        }
        return url
    }
}
