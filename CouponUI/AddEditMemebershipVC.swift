//
//  AddMemebership.swift
//  UISample
//
//  Created by 김지섭 on 2016. 11. 11..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit


class AddEditMemebershipVC: UIViewController, UITextFieldDelegate {
    
    
    
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
    
    
    
    @IBOutlet weak var deleteOutlet: UIBarButtonItem!
    
    @IBAction func deleteButton(_ sender: Any) {
               
        let alert = UIAlertController(title: "삭제하시겠습니까?", message: "한 번 삭제한 쿠폰은 복구할 수 없습니다!", preferredStyle: .alert)
        let delete = UIAlertAction(title: "삭제", style: .destructive) {
            (_) in
            if self.membershipToEdit != nil {
                context.delete(self.membershipToEdit!)
                ad.saveContext()
            }
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(delete)
        alert.addAction(cancel)
        self.present(alert, animated: true)
        
    }

    
    //
    //viewLoad
    //
    
    // 복분으로 인한 문자 입력 방지 및 여백 삭제
    @IBAction func barcodeTextField(_ sender: Any) {
        paramBarcode.text = numParsing(paramBarcode.text!)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if membershipToEdit != nil {
            loadMembershipData()
            //수정 버튼을 통해 들어온 것 확인
            self.navigationItem.title = "멤버십 수정"
            //네비게이션 타이틀 변경
            self.navigationItem.rightBarButtonItem?.title = "수정"
        } else {
            self.navigationItem.title = "멤버십 추가"
            self.deleteOutlet.isEnabled = false
            self.deleteOutlet.tintColor = UIColor(netHex: 0xF66623, alpha: 0)

        }
        
        
        
        //다른 곳 터치시 키보드 제거 및 프레임 원위치
        self.hideKeyboardWhenTappedAround()
        
        //툴바
        addInputAccessoryForTextFields(textFields: [paramBrand,paramBarcode],dismissable: true, previousNextable: true)
        //네비 아이템 폰트
        

        choiceButton.setImage(MemcooView.imageOfLogoSelectButton(), for: .normal)
     

    }
    
    
    
    override func viewDidDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: Notification.Name.UIKeyboardDidHide, object: nil)
    }
    
    //텍스트 필드 관련
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        UIView.animate(withDuration: 0.25, animations: {
            self.view.frame.origin.y -= 200
        }, completion: nil)
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.view.endEditing(true)
        UIView.animate(withDuration: 0.15, animations: {
            self.view.frame.origin.y += 200
        }, completion: nil)
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
        } else if (Double(self.paramBarcode.text!) == nil) {
            let color = UIColor.red
            paramBarcode.layer.borderWidth = 1
            paramBarcode.layer.cornerRadius = CGFloat(7)
            paramBarcode.layer.borderColor = color.cgColor
            paramBarcode.text = ""
            paramBarcode.placeholder = "숫자만 입력해 주세요"
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
            if let logoImg = paramImage.image?.circleMask {
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
   
    

    
    //
    //controller
    //
    
    //membership data를 부르기 위한 펑션
    func loadMembershipData() {
        if let membership = membershipToEdit {
            paramImage.image = membership.toImage?.image as? UIImage
            paramBarcode.text = membership.barcode
            paramBrand.text = membership.toBrand?.title
            realTimeBarcode.image = generateBarcodeFromString(string: membership.barcode)
        }
    }
    
    //extension 부분 정상 작동을 위한 작업
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "logoSelect" {
            
            (segue.destination as? logoSelect)?.delegate = self
        }
        
    }
    
    
    
    //실시간 바코드 생성
    @IBAction func paramBarcodeButton(_ sender: UITextField) {
        realTimeBarcode.image = generateBarcodeFromString(string: paramBarcode.text!)
    }
    
    
    
//텍스트 필드 입력 관련
    


 

//    @IBAction func brandField(_ sender: Any) {
//        // 프레임 이동
//        ad.heightForKeyboard = 2
//        self.moveFrame()
//
//    }
//    
//
//    @IBAction func barcodeField(_ sender: Any) {
//        //프레임 이동
//        ad.heightForKeyboard = 1.5
//        self.moveFrame()
//    }
    

    
}

//extension 부분

    extension AddEditMemebershipVC : logoData {
        func updataData(data: UIImage) {
            //받아온 값 넘기기
            paramImage.image = data
        }
    }
