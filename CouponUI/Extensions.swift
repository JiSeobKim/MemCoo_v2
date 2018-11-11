//
//  CellLayout.swift
//  MemCoo
//
//  Created by kimjiseob on 09/11/2018.
//  Copyright © 2018 mino. All rights reserved.
//

import Foundation
import UIKit



extension CALayer {
    func applyCellShadowLayout() {
        self.cornerRadius = 15
        self.shadowColor = UIColor.black.cgColor
        self.shadowOffset = CGSize(width: 0, height: 2.0)
        self.shadowRadius = 2.0
        self.shadowOpacity = 0.5
        self.masksToBounds = false
    }
    
    func applyCellBolderLayout() {
        self.borderWidth = 1
        self.borderColor = UIColor(netHex: 0xF66623,alpha: 0.3).cgColor
        self.cornerRadius = 15
        self.masksToBounds = true
        
    }
    
    func applyLogoShadowLayout() {
        self.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        self.shadowOffset = CGSize(width : 0,height: 1.0)
        self.shadowOpacity = 0.5
        self.masksToBounds = false
        self.shadowRadius = self.bounds.height * 0.04
    }
}
