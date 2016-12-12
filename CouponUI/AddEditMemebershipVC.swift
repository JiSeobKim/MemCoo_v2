//
//  AddMemebership.swift
//  UISample
//
//  Created by 김지섭 on 2016. 11. 11..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit


class AddEditMemebershipVC: UIViewController {
    
    //
    //model
    //
    
    //showMembershipVC에서 넘어온 membership객체를 받기 위한 membership객체
    var membershipToEdit: Membership?
    
    @IBOutlet weak var LabelBrand: UILabel!
    @IBOutlet weak var LabelBarcode: UILabel!
    @IBOutlet weak var paramBrand: UITextField!
    @IBOutlet weak var paramBarcode: UITextField!
    @IBOutlet weak var paramImage: UIImageView!
    @IBOutlet weak var choiceButton: UIButton!
    
    //saveitem버튼을 눌렀을시 데이터베이스로 저장
    @IBAction func addItem(_ sender: AnyObject) {
        // 추가or수정 버튼 누를시
        
        var membership: Membership!
        
        let imageContext = Image(context: context)
        let brandContext = Brand(context: context)
        
        if membershipToEdit == nil {
            membership = Membership(context: context)
        } else {
            membership = membershipToEdit
        }
        
        //logo 담기
        if let logoImg = paramImage.image {
            imageContext.image = logoImg
            membership.toImage = imageContext
        }
        
        //상품명 담기
        if let title = paramBrand.text {
            brandContext.title = title
            membership.toBrand = brandContext
        }
        
        //바코드번호 담기
        if let barcode = paramBarcode.text {
            membership.barcode = barcode
        }
        
        ad.saveContext()
        
        _ = navigationController?.popViewController(animated: true)
        
//        //예외 처리
//        if self.paramBrand.text == ""
//        { //브랜드 미입력시
//            let color = UIColor.red
//            paramBrand.layer.borderWidth = 1
//            paramBrand.layer.cornerRadius = CGFloat(7)
//            paramBrand.layer.borderColor = color.cgColor
//            paramBrand.placeholder = "입력해 주세요"
//            
//            
//        } else if self.paramBarcode.text == ""{
//            //바코드 미입력시
//            let color = UIColor.red
//            paramBarcode.layer.borderWidth = 1
//            paramBarcode.layer.cornerRadius = CGFloat(7)
//            paramBarcode.layer.borderColor = color.cgColor
//            paramBarcode.placeholder = "입력해 주세요"
//            
//            
//        } else if paramImage.image == nil && cellData.modify == false{
//            let color = UIColor.red
//            choiceButton.layer.borderWidth = 1
//            choiceButton.layer.cornerRadius = CGFloat(7)
//            choiceButton.layer.borderColor = color.cgColor
//            
//        }
//        else {
//            // 구조체 통일
//            
//            cellData.brand = self.paramBrand.text!
//            cellData.barcode = self.paramBarcode.text!
//            cellData.barcodeImage = generateBarcodeFromString(string: paramBrand.text!)
//            
//            
//            
//            
//            if cellData.modify == true {
//                ad.membership[(ad.showNow!)] = cellData
//                
//            } else{
//                ad.membership.append(cellData)
//            }
//            
//            
//            
//            _ = self.navigationController?.popViewController(animated: true)
//            // 화면 되돌아가기
//        }
    }

    //휴지통버튼을 눌렀을시 데이터베이스에서 삭제
    @IBAction func deletePressed(_ sender: UIBarButtonItem) {
        if membershipToEdit != nil {
            context.delete(membershipToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popToRootViewController(animated: true)

    }
    
    
    //
    //viewLoad
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if membershipToEdit != nil {
            loadMembershipData()
        }
       
        
//        if cellData.modify == true {
//            
//            //수정 버튼을 통해 들어온 것 확인
//            self.navigationItem.title = "멤버십 카드 수정"
//            //네비게이션 타이틀 변경
//            self.navigationItem.rightBarButtonItem?.title = "수정"
//            
//            //네비게이션 오른쪽 아이템 타이틀 변경
//            
//            self.paramBrand.text = cellData.brand
//            //텍스트 필드에 브랜드 띄우기
//            self.paramBarcode.text = cellData.barcode
//            //텍스트 필드에 바코드 값 띄우기
//            self.paramImage.image = cellData.logo
//            //이미지 뷰에 로고 띄우기
//        } else {
//            self.navigationItem.title = "멤버십 카드 추가"
//            self.navigationItem.rightBarButtonItem = nil
        
        }
    
    
    //
    //controller
    //
    
    //membership data를 부르기 위한 펑션
    func loadMembershipData() {
        if let membership = membershipToEdit {
            paramImage.image = membership.toImage?.image as? UIImage
            paramBarcode.text = membership.barcode
            paramBrand.text = membership.toBrand?.title
        }
    }
    
    //이건 지섭님이 쓴거라서 이해불가
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MembershipLogoCollection" {
            (segue.destination as? ChoiceMembershipVC)?.delegate = self
        }
    }
    
}

//extension 부분

    extension AddEditMemebershipVC : logoData {
        
        func updataData(data: UIImage) {
            
            paramImage.image = data
            
        }
        
    }
