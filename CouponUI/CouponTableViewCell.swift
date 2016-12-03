//
//  CouponTableViewCell.swift
//  CouponUI
//
//  Created by mino on 2016. 12. 3..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit

class CouponTableViewCell: UITableViewCell {
    @IBOutlet weak var product: UILabel!
    @IBOutlet weak var barcode: UILabel!
    @IBOutlet weak var expired: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
