//
//  AddMemebership.swift
//  UISample
//
//  Created by 김지섭 on 2016. 11. 11..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit


class AddMemebershipVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
      // 멤버쉽 추가 페이지
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        pickerView.dataSource = self
        pickerView.delegate = self
        
        if ad?.modifyCheck == 1 {
            //수정 버튼을 통해 들어온 것 확인
            self.navigationItem.title = "멤버십 카드 수정"
            //네비게이션 타이틀 변경
            self.navigationItem.rightBarButtonItem?.title = "수정"
            //네비게이션 오른쪽 아이템 타이틀 변경
//구조체 통일 후
            self.paramName.text = ad?.membership[(ad?.showNow)!].brand
            self.paramCode.text = ad?.membership[(ad?.showNow)!].barcode
//구조체 통일 전
//            self.paramName.text = ad?.membershipName[(ad?.showNow)!]
//            //텍스트 필드에 이름 값 띄우기
//            self.paramCode.text = String(describing: (ad?.barcode[(ad?.showNow)!])!)
//            //텍스트 필드에 바코드 값 띄우기
            
        }
        
        

        // Do any additional setup after loading the view.
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    @IBOutlet weak var paramName: UITextField!
    @IBOutlet weak var paramCode: UITextField!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var logo = ["default", "KT", "SKT","U+"]
    
    @IBOutlet weak var pickLogo: UILabel!
    
    let ad = UIApplication.shared.delegate as? AppDelegate
   
   
    var AddInfo = MembershipStruct().self

    
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
            
            if ad?.modifyCheck == 1 {
                ad?.membership[(ad?.showNow)!] = AddInfo
            } else{
                ad?.membership.append(AddInfo)
            }
        
        
        // 구조체 통일 전
//        if ad?.modifyCheck == 1 {
//            ad?.membershipName[(ad?.showNow)!] = self.paramName.text!
//            ad?.barcode[(ad?.showNow)!] = Int(self.paramCode.text!)!
//            // 배열 수정
//            
//        }
//        else {
//            ad?.membershipName.append(self.paramName.text!)
//            ad?.barcode.append(Int(self.paramCode.text!)!)
//            ad?.membershipLogo.append(UIImage(named: "default"))
//            // 배열 내에 값 추가
//            
//        }
        
        
        
        
            _ = self.navigationController?.popViewController(animated: true)
            // 화면 되돌아가기
        }
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return logo.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return logo[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    
        pickLogo.text = logo[row]
        AddInfo.logo = UIImage(named: logo[row])
    }
    

}
