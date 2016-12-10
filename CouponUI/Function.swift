//
//  Function.swift
//  MemebershipCoupon
//
//  Created by 김지섭 on 2016. 12. 4..
//  Copyright © 2016년 mino. All rights reserved.
//

import Foundation



////////////////////////////지섭
extension String {
    //String 사이에 String 넣기
    func insert(string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
}

