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
    let strDate = dateFormatter.string(from: theDate) + " 까지"
    
    return strDate
}

func ddayCalculate(endDate: Date) -> String {
    if Date().years(from: endDate) <= 0 {
        if Date().years(from: endDate) == 0 {
            if Date().months(from: endDate) <= 0 {
                if Date().months(from: endDate) == 0 {
                    if Date().days(from: endDate) <= 0 {
                        if Date().days(from: endDate) == 0 {
                            if Date().hours(from: endDate) <= 0 {
                                if Date().hours(from: endDate) == 0 {
                                    return "D-Day"
                                } else {
                                    return "D-1"
                                }
                            } else {
                                return "D-Day"
                            }
                        } else {
                            return "D\(Date().days(from: endDate) - 1)"
                        }
                    }
                } else {
                    return "\(abs(Date().months(from: endDate)))개월"
                }
            }
        } else {
            return "\(abs(Date().years(from: endDate)))년"
        }
    } else {
        return "기한만료"
    }
    return "기한만료"
}

extension Date {
    /// Returns the amount of years from another date
    func years(from date: Date) -> Int {
        return Calendar.current.dateComponents([.year], from: date, to: self).year ?? 0
    }
    /// Returns the amount of months from another date
    func months(from date: Date) -> Int {
        return Calendar.current.dateComponents([.month], from: date, to: self).month ?? 0
    }
    /// Returns the amount of weeks from another date
    func weeks(from date: Date) -> Int {
        return Calendar.current.dateComponents([.weekOfYear], from: date, to: self).weekOfYear ?? 0
    }
    /// Returns the amount of days from another date
    func days(from date: Date) -> Int {
        return Calendar.current.dateComponents([.day], from: date, to: self).day ?? 0
    }
    /// Returns the amount of hours from another date
    func hours(from date: Date) -> Int {
        return Calendar.current.dateComponents([.hour], from: date, to: self).hour ?? 0
    }
    /// Returns the amount of minutes from another date
    func minutes(from date: Date) -> Int {
        return Calendar.current.dateComponents([.minute], from: date, to: self).minute ?? 0
    }
    /// Returns the amount of seconds from another date
    func seconds(from date: Date) -> Int {
        return Calendar.current.dateComponents([.second], from: date, to: self).second ?? 0
    }
    /// Returns the a custom time interval description from another date
    func offset(from date: Date) -> String {
        if years(from: date)   > 0 { return "\(years(from: date))y"   }
        if months(from: date)  > 0 { return "\(months(from: date))M"  }
        if weeks(from: date)   > 0 { return "\(weeks(from: date))w"   }
        if days(from: date)    > 0 { return "\(days(from: date))d"    }
        if hours(from: date)   > 0 { return "\(hours(from: date))h"   }
        if minutes(from: date) > 0 { return "\(minutes(from: date))m" }
        if seconds(from: date) > 0 { return "\(seconds(from: date))s" }
        return ""
    }
}


