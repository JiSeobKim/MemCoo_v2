//
//  Function.swift
//  MemebershipCoupon
//
//  Created by 김지섭 on 2016. 12. 4..
//  Copyright © 2016년 mino. All rights reserved.
//

import Foundation
import UIKit


////////////////////////////지섭
extension String {
    //String 사이에 String 넣기
    func insert(string:String,ind:Int) -> String {
        return  String(self.characters.prefix(ind)) + string + String(self.characters.suffix(self.characters.count-ind))
    }
}

//바코드 4자리 마다 하이픈 넣어주기
func addHyphen(data:String) -> String {
    var barcode = data
    let stringCount = barcode.characters.count
    
    var i : Int = 1
    
    while(i < stringCount) {
        
        if i % 4 == 0 {
            let k = (i/4 - 1) * 5
            barcode = barcode.insert(string: "-", ind: (4 + k))
        }
        i += 1
    }
    
    
    
    
    return barcode
}

//vc2->vc1 데이터 전송을 위한 프로토콜
protocol logoData {
    func updataData(data: UIImage)
}


// 키보드 사라지게 & 프레임 이동
extension UIViewController {
    //키보드 숨김
    func hideKeyboardWhenTappedAround() {
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
     
    }
    func dismissKeyboard() {
        view.endEditing(true)
    }
    func moveFrame(){
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(UIViewController.keyboardWillHide), name: Notification.Name.UIKeyboardWillHide, object: nil)
    }
    //프레임 위로이동
    func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / ad.heightForKeyboard!}
        }
    }
    //프레임 원위치
    func keyboardWillHide(notification: Notification) {
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        
    }
    
}

extension UIViewController {
    func addInputAccessoryForTextFields(textFields: [UITextField], dismissable: Bool = true, previousNextable: Bool = false) {
        for (index, textField) in textFields.enumerated() {
            //툴바 사이즈 및 컬러
            let toolbar: UIToolbar = UIToolbar()
            toolbar.sizeToFit()
            toolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolbar.barStyle = UIBarStyle.default
            
            //툴바에 넣을 아이템 배열
            var items = [UIBarButtonItem]()
            
            
            if previousNextable {
                
                //이전 버튼
                let previousButton = UIBarButtonItem(title: "<", style: .plain, target: nil, action: nil)
                previousButton.width = 30
                if textField == textFields.first {
                    previousButton.isEnabled = false
                } else {
                    previousButton.target = textFields[index - 1]
                    previousButton.action = #selector(UITextField.becomeFirstResponder)
                }
                
                //다음 버튼
                let nextButton = UIBarButtonItem(title: ">", style: .plain, target: nil, action: nil)
                nextButton.width = 30
                if textField == textFields.last {
                    nextButton.isEnabled = false
                } else {
                    nextButton.target = textFields[index + 1]
                    nextButton.action = #selector(UITextField.becomeFirstResponder)
                }
                
                //툴바에 쓸 아이템 추가
                items.append(contentsOf: [previousButton, nextButton])
            }
            
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing))
            items.append(contentsOf: [spacer, doneButton])
            
            toolbar.setItems(items, animated: false)
            textField.inputAccessoryView = toolbar
        }
    }
    
    func addInputAccessoryForTextViews(textViews: [UITextView], dismissable: Bool = true, previousNextable: Bool = false) {
        for (index, textField) in textViews.enumerated() {
            //툴바 사이즈 및 컬러
            let toolbar: UIToolbar = UIToolbar()
            toolbar.sizeToFit()
            toolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolbar.barStyle = UIBarStyle.default
            
            //툴바에 넣을 아이템 배열
            var items = [UIBarButtonItem]()
            
            
            if previousNextable {
                
                //이전 버튼
                let previousButton = UIBarButtonItem(title: "<", style: .plain, target: nil, action: nil)
                previousButton.width = 30
                if textField == textViews.first {
                    previousButton.isEnabled = false
                } else {
                    previousButton.target = textViews[index - 1]
                    previousButton.action = #selector(UITextField.becomeFirstResponder)
                }
                
                //다음 버튼
                let nextButton = UIBarButtonItem(title: ">", style: .plain, target: nil, action: nil)
                nextButton.width = 30
                if textField == textViews.last {
                    nextButton.isEnabled = false
                } else {
                    nextButton.target = textViews[index + 1]
                    nextButton.action = #selector(UITextField.becomeFirstResponder)
                }
                
                //툴바에 쓸 아이템 추가
                items.append(contentsOf: [previousButton, nextButton])
            }
            
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing))
            items.append(contentsOf: [spacer, doneButton])
            
            toolbar.setItems(items, animated: false)
            textField.inputAccessoryView = toolbar
        }
    }
}


