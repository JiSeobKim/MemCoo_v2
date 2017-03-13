//
//  ParsingOCR.swift
//  MemebershipCoupon
//
//  Created by mino on 2017. 1. 3..
//  Copyright © 2017년 mino. All rights reserved.
//

import Foundation
import UIKit

class ParsingOCR {
    
    //쿠폰정보를 담는 컨테이너
    struct CouponInfo {
        //var title: String?
        var barcode: String?
        //var expireDate: String?
        var originalText: String
    }
    
    func parsing(textFromClipboard: String) -> CouponInfo {
        //var title: String?
        var barcode: String?
        //var expireDate: String?
        var originalText: String
        
        // 메세지 원본을 줄바꿈 구분자를 기준으로 나누어서 배열에 담는다 \r과 \n모두 각각 적용
        var seperateByLine: [String]
        originalText = textFromClipboard
        
        if textFromClipboard.contains("\r"){
            seperateByLine = textFromClipboard.components(separatedBy: "\r")
        }
        else {
            seperateByLine = textFromClipboard.components(separatedBy: "\n")
        }
        //모든 배열의 요소를 검사한다.
        for key in seperateByLine {
            if let strInt = Int(key) {
                barcode = "\(strInt)"
                print("\(strInt)")
            }
        }
        
        let coupon = CouponInfo(barcode: barcode, originalText: originalText)
        
        return coupon
    }
}
