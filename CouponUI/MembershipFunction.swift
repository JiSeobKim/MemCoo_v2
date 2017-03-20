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

//숫자 긁어오기

func numParsing(_ param : String) -> String {
    var result = ""
    
    let process = param.components(separatedBy:" ")
    
    for item in process {
        let components = item.components(separatedBy: CharacterSet.decimalDigits.inverted).joined(separator:"")
        
        if let intVal = Int(components) {
            result += String(intVal)
        }
    }
    
    return result

    
}


//delay Function

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
        
     
        if ad.heightForKeyboard != nil {
            
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            if self.view.frame.origin.y == 64 {
                self.view.frame.origin.y -= keyboardSize.height / ad.heightForKeyboard!
                }
            }
            
            
        }
    }
    //프레임 원위치
    func keyboardWillHide(notification: Notification) {
        self.view.frame = CGRect(x: 0, y: 64, width: self.view.frame.width, height: self.view.frame.height)
        ad.heightForKeyboard = 2
    }
    
}




extension UIViewController {
    
    func addInputAccessoryForTextFields(textFields: [UITextField], dismissable: Bool = true, previousNextable: Bool = false) {
        for (index, textField) in textFields.enumerated() {
            //툴바 사이즈 및 컬러
            let toolbar: UIToolbar = UIToolbar()
            toolbar.sizeToFit()
            toolbar.tintColor = UIColor(red: 1/255, green: 1/255, blue: 1/255, alpha: 1)
            toolbar.barStyle = UIBarStyle.default
            
            //툴바에 넣을 아이템 배열
            var items = [UIBarButtonItem]()
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            
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
            
                        //Today 버튼
            let todayButton = UIBarButtonItem(title: "Today", style: .plain, target: nil, action: nil)
            todayButton.width = 30
            if textFields.count == 3, textField == textFields.last {
                todayButton.action = #selector(self.datePickerTodayButton)
                
            } else {
                todayButton.isEnabled = false
                todayButton.tintColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
                
            }

           
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing))
            
            if textFields.count == 3 {
                items.append(contentsOf: [spacer, todayButton,spacer, doneButton])
            } else {
                items.append(contentsOf: [spacer, doneButton])
            }
            toolbar.setItems(items, animated: false)
            textField.inputAccessoryView = toolbar
        }
        
        
    }
    func datePickerTodayButton(_ a : UIBarButtonItem) {
        let vc = self as? CouponAddViewController
        let todaysDate = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        vc?.expiredDate.text = dateFormatter.string(from: todaysDate)
        self.dismissKeyboard()
    }
    
    
    func addInputAccessoryForTextViews(textViews: [UITextView], dismissable: Bool = true, previousNextable: Bool = false) {
        for (_, textField) in textViews.enumerated() {
            //툴바 사이즈 및 컬러
            let toolbar: UIToolbar = UIToolbar()
            toolbar.sizeToFit()
            toolbar.tintColor = UIColor(red: 76/255, green: 217/255, blue: 100/255, alpha: 1)
            toolbar.barStyle = UIBarStyle.default
            
            //툴바에 넣을 아이템 배열
            var items = [UIBarButtonItem]()
            
            
//            if previousNextable {
//                
//                //이전 버튼
//                let previousButton = UIBarButtonItem(title: "<", style: .plain, target: nil, action: nil)
//                previousButton.width = 30
//                if textField == textViews.first {
//                    previousButton.isEnabled = false
//                } else {
//                    previousButton.target = textViews[index - 1]
//                    previousButton.action = #selector(UITextField.becomeFirstResponder)
//                }
//                
//                //다음 버튼
//                let nextButton = UIBarButtonItem(title: ">", style: .plain, target: nil, action: nil)
//                nextButton.width = 30
//                if textField == textViews.last {
//                    nextButton.isEnabled = false
//                } else {
//                    nextButton.target = textViews[index + 1]
//                    nextButton.action = #selector(UITextField.becomeFirstResponder)
//                }
//                
//                //툴바에 쓸 아이템 추가
//                items.append(contentsOf: [previousButton, nextButton])
//            }
            
            let spacer = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
            let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: view, action: #selector(UIView.endEditing))
            items.append(contentsOf: [spacer, doneButton])
            
            toolbar.setItems(items, animated: false)
            textField.inputAccessoryView = toolbar
        }
    }
}

//헥사 코드 사용
extension UIColor {
    convenience init(red: Int, green: Int, blue: Int, alphaValue: CGFloat) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alphaValue)
    }
    
    convenience init(netHex:Int, alpha:CGFloat) {
        self.init(red:(netHex >> 16) & 0xff, green:(netHex >> 8) & 0xff, blue:netHex & 0xff, alphaValue: alpha)
    }
}


extension UIImage {
    var circleMask: UIImage {
        let square = size.width < size.height ? CGSize(width: size.width, height: size.width) : CGSize(width: size.height, height: size.height)
        let imageView = UIImageView(frame: CGRect(origin: CGPoint(x: 0, y: 0), size: square))
        imageView.contentMode = UIViewContentMode.scaleAspectFill
        imageView.image = self
        imageView.layer.cornerRadius = square.width/2
        imageView.layer.borderColor = UIColor(netHex: 0xF66623, alpha: 0.78).cgColor
        imageView.layer.borderWidth = 1
        imageView.layer.masksToBounds = true
        UIGraphicsBeginImageContext(imageView.bounds.size)
        imageView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let result = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return result!
    }
}

