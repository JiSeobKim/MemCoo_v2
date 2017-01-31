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


// 키보드 사라지게 하는 코드
extension UIViewController {



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
    
    func keyboardWillShow(notification: Notification) {
        
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height / 3            }
        }
    }
    func keyboardWillHide(notification: Notification) {
        self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
    }
    
}



