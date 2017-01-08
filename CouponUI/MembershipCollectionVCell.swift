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

    @IBOutlet weak var favorite: UIImageView!
    
    //choicecell 이 가지고 있는 값
    @IBOutlet weak var choiceLogoShow: UIImageView!
    @IBOutlet weak var choiceLogoName: UILabel!
    
    //cell 생성 cell viewcontroll에서의 정의(실질적인 셀생성정의)
    func configureCell(item: Membership) {
        
        viewLogoName.text = item.toBrand?.title
        viewLogoShow.image = item.toImage?.image as? UIImage
        if item.favorite == true {
            favorite.image = UIImage(named: "Favorite")
            let color = UIColor.yellow
            viewLogoName.layer.backgroundColor = color.cgColor
            viewLogoName.layer.cornerRadius = 10
        } else {
            favorite.image = nil
            viewLogoName.layer.backgroundColor = nil

        }
        
    }
    
}

