//
//  NavigationSettingView.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 12/03/2017.
//  Copyright © 2017 mino. All rights reserved.
//

import UIKit

private var _setLightTheme : Bool = false

extension UINavigationBar {

    @IBInspectable var setLightTheme: Bool {
        get {
            return _setLightTheme
        }
        
        set {
            _setLightTheme = newValue
            
            if _setLightTheme {
                self.tintColor = UIColor(red: 247/255, green: 114/255, blue: 39/255, alpha: 1)
                self.titleTextAttributes = [NSFontAttributeName: UIFont(name: "Apple SD Gothic Neo", size: 20)!, NSForegroundColorAttributeName: UIColor(red: 247/255, green: 114/255, blue: 39/255, alpha: 1)]
                
                self.isTranslucent = false
                self.isOpaque = true
    
                
                
                
            }
            
        }
    }
    
}
