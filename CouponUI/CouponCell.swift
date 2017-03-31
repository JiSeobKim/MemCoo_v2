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
    @IBOutlet weak var favoriteFlagView: FavoriteFlag!
    
    func configureCell(item: Coupon) {
        title.text = item.title
        
        if item.favorite == true {
            favoriteFlagView.isHidden = false
        }
        else {
            favoriteFlagView.isHidden = true
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        logo.image = item.toImage?.image as? UIImage
        dday.text = ddayCalculate(endDate: item.expireDate as! Date)
    }
}

