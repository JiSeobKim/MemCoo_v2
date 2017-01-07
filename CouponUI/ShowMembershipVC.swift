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
        ap.brightSwitch = false
        //화면이 사라질때 밝기 수정 off
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        ap.brightSwitch = true
        //현재 페이지에선 밝기 수정 on
        
        if cellData != nil {
            loadMembershipData()
        }
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
    }

    override func viewWillAppear(_ animated: Bool) {
        if cellData != nil {
            loadMembershipData()
        }
        
        UIScreen.main.brightness = 1.0
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        UIScreen.main.brightness = ap.bright!
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


