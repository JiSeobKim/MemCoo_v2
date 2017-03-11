//
//  CouponWidgetCell.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 13/02/2017.
//  Copyright © 2017 mino. All rights reserved.
//

import UIKit

class CouponWidgetCell: UICollectionViewCell {
    
    @IBOutlet weak var logo: UIImageView!
    
    func configureCell(item: Favorite) {
        logo.image = item.toCoupon?.toImage?.image as? UIImage!
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        

        layer.cornerRadius = self.frame.height / 2.3

    }
    
}
