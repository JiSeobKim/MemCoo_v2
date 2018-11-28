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
                self.titleTextAttributes = convertToOptionalNSAttributedStringKeyDictionary([NSAttributedString.Key.foregroundColor.rawValue: UIColor(red: 247/255, green: 114/255, blue: 39/255, alpha: 1)])
                
                self.isTranslucent = false
                self.isOpaque = true
                
            }
            
        }
    }
    
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertToOptionalNSAttributedStringKeyDictionary(_ input: [String: Any]?) -> [NSAttributedString.Key: Any]? {
	guard let input = input else { return nil }
	return Dictionary(uniqueKeysWithValues: input.map { key, value in (NSAttributedString.Key(rawValue: key), value)})
}
