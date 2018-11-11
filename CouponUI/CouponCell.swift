//
//  CouponCell.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 05/12/2016.
//  Copyright © 2016 mino. All rights reserved.
//

import UIKit

class CouponCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var favorite: UILabel!
    @IBOutlet weak var dday: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var favoriteFlagView: UIView!
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var outView: UIView!
    
    func configureCell(item: Coupon) {
        title.text = item.title
        
        if item.isFavorite == true {
            favoriteFlagView.isHidden = false
        }
        else {
            favoriteFlagView.isHidden = true
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        logo.image = item.toImage?.image as? UIImage
        dday.text = ddayCalculate(endDate: item.expireDate! as Date)
        
        
        
        
        
        mainView.layer.applyCellBolderLayout()
        outView.layer.applyCellShadowLayout()
        logo.layer.cornerRadius = logo.bounds.height / 2
        
        logo.layer.shadowRadius = 5
        
        logo.layer.borderWidth = 1
        logo.layer.borderColor = UIColor(netHex: 0xF66623,alpha: 0.78).cgColor
        logo.layer.cornerRadius = (logo.frame.width/2)
        logo.layer.masksToBounds = true
        
        logo.layer.applyLogoShadowLayout()
    }
}

