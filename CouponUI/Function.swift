//
//  Function.swift
//  MemebershipCoupon
//
//  Created by 김지섭 on 2016. 12. 4..
//  Copyright © 2016년 mino. All rights reserved.
//

import Foundation


extension String {
    func insert(string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
}

//test


//test3
//test4


// Test 2
