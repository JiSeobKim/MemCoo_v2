//
//  FavoriteCell.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 06/01/2017.
//  Copyright © 2017 mino. All rights reserved.
//

import UIKit

class FavoriteCell: UITableViewCell {
    
    @IBOutlet weak var barcodeImg: UIImageView!
    @IBOutlet weak var logo: UIImageView!
    
    
    func configureCell(item: Any) {
        
        if let membership = item as? Membership {
            let barcodeNo = membership.barcode
            barcodeImg.image = generateBarcodeFromString(string: barcodeNo)
            logo.image = membership.toImage?.image as! UIImage?
        } else if let coupon = item as? Coupon {
            let barcodeNo = coupon.barcode
            barcodeImg.image = generateBarcodeFromString(string: barcodeNo)
            logo.image = coupon.toImage?.image as! UIImage?
        }
       
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
