//
//  SecondViewController.swift
//  UISample
//
//  Created by mino on 2016. 11. 11..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit

class MembershipCollectionVCell : UICollectionViewCell {

 
    //viewcell 이 가지고 있는 값
    @IBOutlet weak var viewLogoShow: UIImageView!
    @IBOutlet weak var viewLogoName: UILabel!

    //choicecell 이 가지고 있는 값
    @IBOutlet weak var choiceLogoShow: UIImageView!
    @IBOutlet weak var choiceLogoName: UILabel!
    
    func configureCell(item: Membership) {
        
        viewLogoName.text = item.toBrand?.title
        viewLogoShow.image = item.toImage?.image as? UIImage
        
    }
    
}

