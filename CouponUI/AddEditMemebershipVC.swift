//
//  AddMemebership.swift
//  UISample
//
//  Created by 김지섭 on 2016. 11. 11..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit


class AddEditMemebershipVC: UIViewController {
      // 멤버쉽 추가 페이지
    
    var cellData : MembershipClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        if ad.modifyCheck == true {
            //수정 버튼을 통해 들어온 것 확인
            self.navigationItem.title = "멤버십 카드 수정"
            //네비게이션 타이틀 변경
            self.navigationItem.rightBarButtonItem?.title = "수정"
            
            //네비게이션 오른쪽 아이템 타이틀 변경
            
            self.paramBrand.text = ad.membership[(ad.showNow)!].brand
            //텍스트 필드에 브랜드 띄우기
            self.paramBarcode.text = ad.membership[(ad.showNow)!].barcode
            //텍스트 필드에 바코드 값 띄우기
            self.paramImage.image = ad.membership[(ad.showNow)!].logo
            //이미지 뷰에 로고 띄우기
        } else {
            self.navigationItem.title = "멤버십 카드 추가"
            self.navigationItem.rightBarButtonItem?.title = "추가"
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if ad.logoChoice != nil  {
            paramImage.image = ad.logoImage[(ad.logoChoice)!]
            // 로고 선택시 이미지 띄워줌 (수정 모드가 아닐 경우만)
        }
    }
    //test
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBOutlet weak var LabelBrand: UILabel!
    @IBOutlet weak var LabelBarcode: UILabel!
    @IBOutlet weak var LabelLogo: UILabel!
    
    @IBOutlet weak var paramBrand: UITextField!
    @IBOutlet weak var paramBarcode: UITextField!
    @IBOutlet weak var paramImage: UIImageView!
    
    @IBOutlet weak var choiceButton: UIButton!
    
   
   
    var AddInfo = MembershipClass()

    
    @IBAction func Add(_ sender: AnyObject) {
        // 추가or수정 버튼 누를시
       
        //예외 처리
        if self.paramBrand.text == ""
        { //브랜드 미입력시
            let color = UIColor.red
            paramBrand.layer.borderWidth = 1
            paramBrand.layer.cornerRadius = CGFloat(7)
            paramBrand.layer.borderColor = color.cgColor
            paramBrand.placeholder = "입력해 주세요"
            
     
        } else if self.paramBarcode.text == ""{
            //바코드 미입력시
            let color = UIColor.red
            paramBarcode.layer.borderWidth = 1
            paramBarcode.layer.cornerRadius = CGFloat(7)
            paramBarcode.layer.borderColor = color.cgColor
            paramBarcode.placeholder = "입력해 주세요"

            
        } else if ad.logoChoice == nil && ad.modifyCheck == false{
            let color = UIColor.red
            choiceButton.layer.borderWidth = 1
            choiceButton.layer.cornerRadius = CGFloat(7)
            choiceButton.layer.borderColor = color.cgColor
            
        } else {
        // 구조체 통일
        
            AddInfo.brand = self.paramBrand.text!
            AddInfo.barcode = self.paramBarcode.text!
            AddInfo.barcodeImage = ad.fromString(string: self.paramBarcode.text!)
            if ad.logoChoice != nil {
            AddInfo.logo = ad.logoImage[(ad.logoChoice)!]
            }
            
            if ad.modifyCheck == true {
                ad.membership[(ad.showNow!)] = AddInfo
            
            } else{
                ad.membership.append(AddInfo)
            }
        
       
        
            _ = self.navigationController?.popViewController(animated: true)
            // 화면 되돌아가기
        }
    }
    
    

}
