//
//  Bright.swift
//  MemCoo
//
//  Created by 김지섭 on 2017. 5. 19..
//  Copyright © 2017년 mino. All rights reserved.
//

import Foundation
import UIKit

func AutoBrightCheck() {
    let userData2 = UserDefaults.standard
    if (userData2.object(forKey: "BrightOff") as? Bool) != nil  {
        if (userData2.object(forKey: "BrightOff") as? Bool)! {
            ad.brightOffData = true
        } else {
            ad.brightOffData = false
        }
    }
}

func BrightApply() {
    if ad.brightOffData == false {
    ad.brightSwitch = true
    UIScreen.main.brightness = 1.0
    }
}

func BrightReturn(){
    ad.brightSwitch = false
    UIScreen.main.brightness = ad.bright!
}
