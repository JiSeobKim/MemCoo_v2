//
//  ChoiceMembershipVC.swift
//  MemebershipCoupon
//
//  Created by 김지섭 on 2016. 12. 5..
//  Copyright © 2016년 mino. All rights reserved.
//

import Foundation
import UIKit

class ChoiceMembershipVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource  {
    
    var delegate : logoData?
    var logoNumber : Int?
    
    var logoImage = [UIImage(named:"CafeLogo"),UIImage(named:"CallLogo"),UIImage(named:"ClothesLogo"),UIImage(named:"CosmeticLogo"),UIImage(named:"PointLogo"),UIImage(named:"KT"),UIImage(named:"SKT"),UIImage(named:"U+")]
    
    var logoName = ["카페","통신사","옷가게","화장품","포인트","KT","SKT","U+"]

    override func viewDidLoad() {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        

        return logoImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "choicecell", for: indexPath) as! MembershipCollectionVCell
        
        cell.choiceLogoShow.image = logoImage[indexPath.row]
        cell.choiceLogoName.text = logoName[indexPath.row]
        
        return cell
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //셀 터치 시 하이라이트 효과
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.red.cgColor
        
        //네비 타이틀 변경
        self.navigationItem.title = logoName[indexPath.row]
        //선택된 셀 번호 전달
        logoNumber = indexPath.row
    }
    

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = nil
        cell?.layer.borderWidth = 0.0
    }
    

    
    
}

protocol logoData {
    func updataData(data: UIImage)
}
