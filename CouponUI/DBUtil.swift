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

func daysBetweenDates(startDate: Date, endDate: Date) -> String
{
    let calendar = Calendar.current
    
    let components = calendar.dateComponents([Calendar.Component.day], from: startDate, to: endDate)
    
    if(components.day! < 0){
        return "기간 만료"
    } else {
        return "D-\(components.day! + 1)"
    }
}
