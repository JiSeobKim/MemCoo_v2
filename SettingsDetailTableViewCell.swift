//
//  SettingsDetailTableViewCell.swift
//  MemebershipCoupon
//
//  Created by mino on 2017. 1. 7..
//  Copyright © 2017년 mino. All rights reserved.
//

import UIKit

class SettingsDetailTableViewCell: UITableViewCell {
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var onOffSwitch: UISwitch!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
