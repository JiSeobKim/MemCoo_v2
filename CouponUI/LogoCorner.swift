//
//  LogoCorner.swift
//  MemebershipCoupon
//
//  Created by 김지섭 on 2017. 2. 8..
//  Copyright © 2017년 mino. All rights reserved.
//

import Foundation
import UIKit

private var logoCorner = false


extension UIImageView {
    @IBInspectable var logoCornerDesign : Bool {
        get {
            return logoCorner
        }
        
        set{
            logoCorner = newValue
                if logoCorner {
                    self.layer.borderWidth = 2
                    self.layer.borderColor = UIColor(red: 244/255.0, green: 244/255.0, blue: 244/255.0, alpha: 1.0).cgColor
                    self.layer.cornerRadius = 15
                } else {
                    self.layer.borderWidth = 0
                    self.layer.cornerRadius = 0
            }
        }
    }
}
