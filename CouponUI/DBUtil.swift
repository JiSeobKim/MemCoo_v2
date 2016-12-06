//
//  DBUtil.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 05/12/2016.
//  Copyright © 2016 mino. All rights reserved.
//

import Foundation

func displayTheDate(theDate:Date) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = "yyyy-MM-dd"
    let strDate = dateFormatter.string(from: theDate)
    return strDate
}
