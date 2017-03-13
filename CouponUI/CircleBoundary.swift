//
//  CircleBoundary.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 13/03/2017.
//  Copyright © 2017 mino. All rights reserved.
//

import Foundation
import UIKit

@IBDesignable
class CircleBoundary: UIImageView {
    
    private var circle = false
    @IBInspectable var conerRadius: CGFloat = 0 {
        didSet {
            if circle {
                layer.cornerRadius = frame.height / 2
            } else {
                layer.cornerRadius = conerRadius
            }
            layer.masksToBounds = conerRadius > 0
        }
    }
    @IBInspectable var circleBoundary: Bool {
        
        get {
            return circle
        }
        set {
            circle = newValue
        }
//        didSet {
//                layer.masksToBounds = false
//                contentMode = UIViewContentMode.scaleAspectFill
//                layer.cornerRadius = frame.height / 2
//                layer.borderColor = UIColor(red: 246/255, green: 102/255, blue: 35/255, alpha: 0.78).cgColor
//                layer.borderWidth = 1
//                clipsToBounds = true
//        }
    }
    
    @IBInspectable var borderWidth: CGFloat = 0 {
        didSet {
            layer.borderWidth = borderWidth
        }
    }
    
    @IBInspectable var borderColor: UIColor? {
        didSet{
            layer.borderColor = borderColor?.cgColor
        }
    }
    
    @IBInspectable var bgColor: UIColor? {
        didSet{
            backgroundColor = bgColor
        }
    }
    
}
