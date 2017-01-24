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
    var membership: Membership!
    var bright : CGFloat?
    
    

    @IBOutlet weak var LabelBrand: UILabel!
    @IBOutlet weak var LabelBarcode: UILabel!
    @IBOutlet weak var paramBrand: UITextField!
    @IBOutlet weak var paramBarcode: UITextField!
    @IBOutlet weak var paramImage: UIImageView!
    @IBOutlet weak var choiceButton: UIButton!
    @IBOutlet weak var realTimeBarcode: UIImageView!
    
    @IBOutlet weak var deleteButton: UIButton!
    
    
    
    
    //
    //viewLoad
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if membershipToEdit != nil {
            loadMembershipData()
            //수정 버튼을 통해 들어온 것 확인
            self.navigationItem.title = "멤버십 카드 수정"
            //네비게이션 타이틀 변경
            self.navigationItem.rightBarButtonItem?.title = "수정"
        } else {
            self.navigationItem.title = "멤버십 카드 추가"
            self.deleteButton.isHidden = true
        }
        
        //삭제 버튼 테두리
        deleteButton.layer.cornerRadius = deleteButton.frame.height / 2
        
        //키보드 크기만큼 뷰를 위로 이동.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)


    }
    

    
    
    //saveitem버튼을 눌렀을시 데이터베이스로 저장
    @IBAction func addItem(_ sender: AnyObject) {
        // 추가or수정 버튼 누를시

        let imageContext = Image(context: context)
        let brandContext = Brand(context: context)
        
        
        var inputCheck1 = false
        var inputCheck2 = false
        //입력 확인 변수
        
        //예외 처리
        if self.paramBrand.text == ""
        { //브랜드 미입력시
            let color = UIColor.red
            paramBrand.layer.borderWidth = 1
            paramBrand.layer.cornerRadius = CGFloat(7)
            paramBrand.layer.borderColor = color.cgColor
            paramBrand.placeholder = "입력해 주세요"
            
            
        } else {
            paramBrand.layer.borderWidth = 0
            inputCheck1 = true
        }
            
        if self.paramBarcode.text == ""{
            //바코드 미입력시
            let color = UIColor.red
            paramBarcode.layer.borderWidth = 1
            paramBarcode.layer.cornerRadius = CGFloat(7)
            paramBarcode.layer.borderColor = color.cgColor
            paramBarcode.placeholder = "입력해 주세요"
        } else {
            paramBarcode.layer.borderWidth = 0
            inputCheck2 = true
        }
        
        if inputCheck1 == true && inputCheck2 == true {
            
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
        }

    }

    //휴지통버튼을 눌렀을시 데이터베이스에서 삭제
   
    
    @IBAction func deletePressed(_ sender: Any) {
        if membershipToEdit != nil {
            context.delete(membershipToEdit!)
            ad.saveContext()
        }
        _ = navigationController?.popToRootViewController(animated: true)
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
    
    //extension 부분 정상 작동을 위한 작업
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoSelect" {
            (segue.destination as? logoSelect)?.delegate = self
        }
    }
    
    //텍스트 필드가 아닌 곳을 터치했을 때 키보드 닫기.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        paramBrand.resignFirstResponder()
        paramBarcode.resignFirstResponder()
    }
    
    //실시간 바코드 생성
    @IBAction func paramBarcodeButton(_ sender: UITextField) {
        realTimeBarcode.image = generateBarcodeFromString(string: paramBarcode.text!)
    }
    
    //키보드 크기만큼 뷰를 위로 이동.
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }

    
    
    
    
    
    
    
}

//extension 부분

    extension AddEditMemebershipVC : logoData {
        
        func updataData(data: UIImage) {
            
            paramImage.image = data
            
        }
        
    }
