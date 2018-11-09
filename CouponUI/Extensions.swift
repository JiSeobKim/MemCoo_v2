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
}
