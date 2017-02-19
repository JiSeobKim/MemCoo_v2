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
    
    func configureCell(item: Coupon) {
        title.text = item.title
        
        //category는 to many관계이므로 처리하기 어렵다.
        if item.favorite == true {
            favorite.text = "★"
        }
        else {
            favorite.text = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        logo.image = item.toImage?.image as? UIImage
//        barcodeImg.image = generateBarcodeFromString(string: item.barcode)
        dday.text = ddayCalculate(endDate: item.expireDate as! Date)
    }
}

