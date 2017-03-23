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


    @IBOutlet weak var favorite: UIView!

    
    //choicecell 이 가지고 있는 값
    @IBOutlet weak var choiceLogoShow: UIImageView!
    @IBOutlet weak var choiceLogoName: UILabel!
    
    //cell 생성 cell viewcontroll에서의 정의(실질적인 셀생성정의)
    func configureCell(item: Membership) {

      

        //Favorite 뷰 다운캐스팅 및 백그라운드 클리어
        _ = favorite as? FavoriteFlag
        favorite.backgroundColor = UIColor.clear
        
        
        viewLogoName.text = item.toBrand?.title
        viewLogoShow.image = (item.toImage?.image as? UIImage)
        // Shadow and Radius
        

        viewLogoShow.layer.borderWidth = 1
        viewLogoShow.layer.borderColor = UIColor(netHex: 0xF66623,alpha: 0.78).cgColor
        viewLogoShow.layer.cornerRadius = (viewLogoShow.frame.width/2)
        viewLogoShow.layer.masksToBounds = true

        
        
        
        if item.favorite == true {
            favorite.isHidden = false
        } else {
            favorite.isHidden = true
        }
        
    }
    
}

