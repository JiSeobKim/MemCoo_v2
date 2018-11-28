//
//  collectionViewController.swift
//  UISample
//
//  Created by 김지섭 on 2016. 11. 11..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit

class ShowMembershipVC: UIViewController, UIGestureRecognizerDelegate {
    
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
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //제스쳐 밝기 조절
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.pan(recognizer:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(panGesture)
        

        
        if cellData != nil {
            loadMembershipData()
        }
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItem.Style.plain, target: nil, action: nil)
        }
        
        //타이틀 명 변경
        if let memebership = cellData{
            self.navigationItem.title = memebership.toBrand?.title
            }
        
        //밝기
        AutoBrightCheck()
        
        
        self.ShowLogo.layer.applyLogoShadowLayout()
        
        
        
    }
    override func viewWillDisappear(_ animated: Bool) {
        BrightReturn()
        //화면이 사라질때 밝기 수정 off
    }

    override func viewWillAppear(_ animated: Bool) {
        if cellData != nil {
            loadMembershipData()
        }
        //현재 페이지에선 밝기 수정 on
        BrightApply()
        if let memebership = cellData{
            self.navigationItem.title = memebership.toBrand?.title
        }
        
    }
    
    
    //밝기 제스쳐
    @objc func pan(recognizer:UIPanGestureRecognizer){
        if recognizer.state == UIGestureRecognizer.State.changed || recognizer.state == UIGestureRecognizer.State.ended {
            let velocity:CGPoint = recognizer.velocity(in: self.view)
            
            if velocity.y > 0{
                var brightness: Float = Float(UIScreen.main.brightness)
                brightness = brightness - 0.03
                UIScreen.main.brightness = CGFloat(brightness)
            }
            else {
                var brightness: Float = Float(UIScreen.main.brightness)
                brightness = brightness + 0.03
                UIScreen.main.brightness = CGFloat(brightness)
            }
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
            barcodeLabel.text = membership.barcode?.addHyphen()
            
            
          
            

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


