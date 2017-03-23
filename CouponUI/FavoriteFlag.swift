//
//  FavoriteFlag.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 13/03/2017.
//  Copyright © 2017 mino. All rights reserved.
//

import UIKit

class FavoriteFlag: UIView {

    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
       
        MemcooView.drawFavoriteFlagForTableCell()
    }
 

}
