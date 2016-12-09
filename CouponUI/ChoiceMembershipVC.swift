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
    
    let ad = UIApplication.shared.delegate as? AppDelegate

    override func viewDidLoad() {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        

        return ad!.logoImage.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "choicecell", for: indexPath) as! MembershipCollectionVCell
        
        cell.choiceLogoShow.image = ad!.logoImage[indexPath.row]
        cell.choiceLogoName.text = ad!.logoName[indexPath.row]
        
        return cell
        
    }
    

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //셀 터치 시 하이라이트 효과
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderWidth = 2.0
        cell?.layer.borderColor = UIColor.red.cgColor
        
        //네비 타이틀 변경
        self.navigationItem.title = ad!.logoName[indexPath.row]
        //선택된 셀 번호 전달
        ad?.showNow = indexPath.row
    }
    

    func collectionView(_ collectionView: UICollectionView, didDeselectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        cell?.layer.borderColor = nil
        cell?.layer.borderWidth = 0.0
    }
    
    @IBAction func Choice(_ sender: Any) {
        //Done 버튼
        _ = self.navigationController?.popViewController(animated: true)
    }
    
}
