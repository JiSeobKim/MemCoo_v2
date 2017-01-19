//
//  collectionViewController.swift
//  UISample
//
//  Created by 김지섭 on 2016. 11. 11..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit

class ShowMembershipVC: UIViewController {
    
    //
    //model
    //

    var cellData : Membership?
    var bright : CGFloat?

    @IBOutlet weak var ShowLogo: UIImageView!
    @IBOutlet weak var barcodeLabel: UILabel!
    @IBOutlet weak var ShowBarcode: UIImageView!
    
    
    
    
    //
    //viewLoad
    //
    override func viewWillDisappear(_ animated: Bool) {
        ad.brightSwitch = false
        UIScreen.main.brightness = ad.bright!
        //화면이 사라질때 밝기 수정 off
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ad.brightSwitch = true
        //현재 페이지에선 밝기 수정 on
        
        if cellData != nil {
            loadMembershipData()
        }
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        //타이틀 명 변경
        if let memebership = cellData{
            self.navigationItem.title = memebership.toBrand?.title
            }
        
        //하단에 그림자 추가
        ShowLogo.layer.borderColor = UIColor.gray.cgColor
        ShowLogo.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        ShowLogo.layer.shadowOffset = CGSize(width : 0,height: 2.0)
        ShowLogo.layer.shadowOpacity = 0.5
        ShowLogo.layer.shadowRadius = 0.0
        ShowLogo.layer.masksToBounds = false
        ShowLogo.layer.cornerRadius = 10.0
        
    }

    override func viewWillAppear(_ animated: Bool) {
        if cellData != nil {
            loadMembershipData()
        }
        
        UIScreen.main.brightness = 1.0
        
    }
    

    //
    //controller
    //
    
    //membership data를 부르는 펑션
    func loadMembershipData() {
        if let membership = cellData {
            ShowLogo.image = membership.toImage?.image as? UIImage
            ShowBarcode.image = generateBarcodeFromString(string: membership.barcode)
            barcodeLabel.text = addHyphen(data: membership.barcode!)
            
            
          
            

        }
    }
    
    //수정시 membership의 객체를 넘기기위한 준비 && 밝기 값 전달
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MembershipEdit" {
            if let vc = segue.destination as? AddEditMemebershipVC {
                vc.membershipToEdit = cellData
                
                if self.bright != nil {
                 vc.bright = self.bright!
                }
            }
        }
    }
}


