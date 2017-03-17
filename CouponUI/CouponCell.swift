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
    @IBOutlet weak var category: UILabel!   //현재 즐겨찾기로 사용 중.
    @IBOutlet weak var expireDate: UILabel!
    @IBOutlet weak var dday: UILabel!
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var barcodeImg: UIImageView!
    
    func configureCell(item: Coupon) {
        title.text = item.title
        
        //category는 to many관계이므로 처리하기 어렵다.
        //현재 카테고리가 아닌 즐겨찾기로 사용 중. 변수명 변경 필요.
        if item.favorite == true {
            category.text = "★"
        }
        else {
            category.text = ""
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        expireDate.text = dateFormatter.string(from: item.expireDate as! Date)
        logo.image = item.toImage?.image as? UIImage
        barcodeImg.image = generateBarcodeFromString(string: item.barcode)
        dday.text = daysBetweenDates(startDate: Date(), endDate: item.expireDate as! Date)
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
