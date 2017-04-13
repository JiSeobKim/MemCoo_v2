//
//  Function.swift
//  MemebershipCoupon
//
//  Created by 김지섭 on 2017. 4. 13..
//  Copyright © 2017년 mino. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alphaValue: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alphaValue)
    }
    
    convenience init(netHex:Int, alpha:CGFloat) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, alphaValue: alpha)
    }
}
