//
//  MembershipWidgetCell.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 13/02/2017.
//  Copyright © 2017 mino. All rights reserved.
//

import UIKit

class MembershipWidgetCell: UICollectionViewCell {
    
    @IBOutlet weak var logo: UIImageView!
    
    func configureCell(item: Favorite) {
        logo.image = item.toMembership?.toImage?.image as? UIImage!
        logo.layer.borderWidth = 1.5
        logo.layer.borderColor = UIColor(netHex: 0xF66623,alpha: 0.3).cgColor
        logo.layer.cornerRadius = (self.frame.width/2)
        logo.layer.masksToBounds = true
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.cornerRadius = self.frame.height / 2.3
    }
    
}


