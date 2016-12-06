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
    
    @IBOutlet weak var category: UILabel!

    @IBOutlet weak var expireDate: UILabel!
    
    @IBOutlet weak var dday: UILabel!
    
    @IBOutlet weak var logo: UIImageView!
    
    @IBOutlet weak var barcodeImg: UIImageView!
    
    func configureCell(item: Coupon) {
        
        title.text = item.title
        //category는 to many관계이므로 처리하기 어렵다.
        category.text = "보류다."
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        expireDate.text = dateFormatter.string(from: item.expireDate as! Date)
        logo.image = item.toBrand?.logo as? UIImage
        barcodeImg.image = item.barcodeImg as? UIImage
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
