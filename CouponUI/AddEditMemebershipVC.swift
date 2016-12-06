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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        if ad?.modifyCheck == true {
            //수정 버튼을 통해 들어온 것 확인
            self.navigationItem.title = "멤버십 카드 수정"
            //네비게이션 타이틀 변경
            self.navigationItem.rightBarButtonItem?.title = "수정"
            //네비게이션 오른쪽 아이템 타이틀 변경

            self.paramName.text = ad?.membership[(ad?.showNow)!].brand
            //텍스트 필드에 브랜드 띄우기
            self.paramCode.text = ad?.membership[(ad?.showNow)!].barcode
            //텍스트 필드에 바코드 값 띄우기
            
        } else {
            self.navigationItem.title = "멤버십 카드 추가"
            self.navigationItem.rightBarButtonItem?.title = "추가"
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBOutlet weak var paramName: UITextField!
    @IBOutlet weak var paramCode: UITextField!
        
    let ad = UIApplication.shared.delegate as? AppDelegate
   
   
    var AddInfo = MembershipClass()

    
    @IBAction func Add(_ sender: AnyObject) {
        // 추가or수정 버튼 누를시
        
        //예외 처리
        if self.paramName.text == ""
        {
            self.paramName.text = "입력해주세요"
        } else if self.paramCode.text == "" {
            self.paramCode.text = "입력해주세요"
        } else {
        // 구조체 통일
        
            AddInfo.brand = self.paramName.text!
            AddInfo.barcode = self.paramCode.text!
            AddInfo.barcodeImage = ad?.fromString(string: self.paramCode.text!)
            
            if ad?.modifyCheck == true {
                ad?.membership[(ad?.showNow)!] = AddInfo
            } else{
                ad?.membership.append(AddInfo)
            }
        
        
        
        
            _ = self.navigationController?.popViewController(animated: true)
            // 화면 되돌아가기
        }
    }
    
    

}
