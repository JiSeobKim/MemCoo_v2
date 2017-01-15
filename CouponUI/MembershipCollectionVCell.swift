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
    
    //cell 생성 cell viewcontroll에서의 정의(실질적인 셀생성정의)
    func configureCell(item: Membership) {
        
        viewLogoName.text = item.toBrand?.title
        viewLogoShow.image = item.toImage?.image as? UIImage
        
//셀 라운드형
        viewLogoShow.layer.cornerRadius = 4
        viewLogoShow.layer.borderWidth = 1
        viewLogoShow.layer.borderColor = UIColor.gray.cgColor
        viewLogoShow.clipsToBounds = true
//        viewLogoShow.layer.shadowColor = UIColor.black.cgColor
//        viewLogoShow.layer.shadowOpacity = 0.8
//        viewLogoShow.layer.shadowRadius = 3
//        viewLogoShow.layer.shadowOffset = CGSize(width: 2.0, height: 2.0)
        
        if item.favorite == true {
            
            let color = UIColor.yellow
            viewLogoName.layer.backgroundColor = color.cgColor
            viewLogoName.layer.cornerRadius = 10
        } else {
            viewLogoName.layer.backgroundColor = nil
        }
        
    }
    
}

