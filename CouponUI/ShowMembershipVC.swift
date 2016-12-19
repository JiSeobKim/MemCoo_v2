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

    @IBOutlet weak var ShowLogo: UIImageView!
    @IBOutlet weak var barcodeLabel: UILabel!
    @IBOutlet weak var ShowBarcode: UIImageView!
    
    @IBOutlet weak var ShowBarcodeRotate: UIImageView!
    @IBOutlet weak var BarcodeLabelRotate: UILabel!
    
    //180도 회전
    //
    //viewLoad
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let angle:CGFloat = CGFloat((180.0*M_PI)/180.0)
        
        ShowBarcodeRotate.transform = CGAffineTransform(rotationAngle: angle)
        BarcodeLabelRotate.transform = CGAffineTransform(rotationAngle: angle)
        
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
            
            
            ShowBarcodeRotate.image = generateBarcodeFromString(string: membership.barcode)
            BarcodeLabelRotate.text = addHyphen(data: membership.barcode!)
            

        }
    }
    
    //수정시 membership의 객체를 넘기기위한 준비
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MembershipEdit" {
            if let vc = segue.destination as? AddEditMemebershipVC {
                vc.membershipToEdit = cellData
            }
        }
    }
}


