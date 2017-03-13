//
//  ParsingBrain.swift
//  cardy
//
//  Created by Joosung Kim on 04/11/2016.
//  Copyright © 2016 Joosung Kim. All rights reserved.
//

import Foundation
import UIKit

class ParsingBrain {

    //쿠폰정보를 담는 컨테이너
    struct CouponInfo {
        var title: String?
        var barcode: String?
        var expireDate: String?
        var originalText: [String]
    }
    
    func parsing(textFromClipboard: [String]?) -> CouponInfo {
        var title: String?
        var barcode: String?
        var expireDate: String?
        var originalText: [String]
        
        // 메세지 원본을 줄바꿈 구분자를 기준으로 나누어서 배열에 담는다 \r과 \n모두 각각 적용
        var seperateByLine: [String] = []
        originalText = textFromClipboard!
        
        if let copiedString = textFromClipboard?.first {
            if copiedString.contains("\r"){
                seperateByLine = copiedString.components(separatedBy: "\r")
            }
            else {
                seperateByLine = copiedString.components(separatedBy: "\n")
            }
        }
        
        //모든 배열의 요소를 검사한다.
        for key in seperateByLine {
            //번호 상품 기간이 의 키워드 필터링
            if key.contains("번호") || key.contains("상품") || key.contains("기간")||key.contains("http") {
                //그 배열에 :가 있는지 검사
                if key.contains(":"){
                    //있다면 정보가 같은 줄에 있을거임
                    //상품명 찾기: 키워드 "상품명"
                    if key.contains("상품명"){
                        //:을 기준으로 끊자
                        let seperatedByColon = key.components(separatedBy: ":")
                        
                        //뒤에나오는 것이 상품명에 대한 내용
            
                        let content = seperatedByColon[1]
                            let refineContent1 = content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                            let refineContent2 = refineContent1.trimmingCharacters(in: CharacterSet.symbols)
                        title = refineContent2
                        
                    }
                        
                    //유효기간 찾기: 키워드 "기간"
                    else if key.contains("기간"){
                        //:을 기준으로 끊자
                        let seperatedByColon = key.components(separatedBy: ":")
                        
                        let content = seperatedByColon[1]
                        let refineContent1 = content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                        let refineContent2 = refineContent1.trimmingCharacters(in: CharacterSet.symbols)
                        expireDate = refineContent2

                        //date 객체 처리는 따로 function을 놓도록 합시다.
////                            let dateFormatter = DateFormatter()
////                            dateFormatter.dateFormat = "yyyy/MM/dd"
//                            //앞 Date??
//                            let date1 = dateFormatter.date(from: refine2) //이것은 Date객체
//                            
//                            //뒤 Date??
//                            let date2 = dateFormatter.string(from: date1!) //이것은 String객체
//                            
//                            couponExpireDate = date2
                    }
                    
                    //바코드 번호 찾기: 키워드 "번호"
                    else if key.contains("번호") {
                        //:을 기준으로 끊자
                        let seperatedByColon = key.components(separatedBy: ":")
                        
                        //한글로 인코딩 될수 없는 경우만 바코드로 인정
                        if seperatedByColon[1].canBeConverted(to: .isoLatin1){
                            let content = seperatedByColon[1]
                            let refineContent1 = content.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
                            let refineContent2 = refineContent1.trimmingCharacters(in: CharacterSet.symbols)
                            //
                            //
                            //
                            //
                            // 쿠폰번호가 복수일때 어떻게 해야할까...
                            //
                            //
                            //
                            //
                            if refineContent2.contains(",") {
                                let multipleCouponNo = refineContent2.components(separatedBy: ",")
                            }
                            
                            
                            barcode = refineContent2
                        }
                    }
                    //URL 찾기: 키워드 "http"
//                    else if key.contains("http"){
//                        //:가 몇번째 의 문자인지 검사
//                        let refine1 = key.trimmingCharacters(in: CharacterSet.whitespacesAndNewlines)
//                        if URL(string: refine1) != nil {
//                            couponURL.content = refine1
//                        }
//                    }
                }
                //:가 없다면 다음 줄에 정보가 있다.
                else {
                    if key.contains("상품명"){
                    }
                }
                
                //:가 있으면 그줄에 정보가 있는거임
                //:가 없으면 그 배열의 스트링 길이값 조사 7정도?
                //7보다 작으면 다음 배열값에 정보가 있는거임
                //그후 각각의 정보가 어떤 값인지 검사
            }
        }
        
        let coupon = CouponInfo(title: title, barcode: barcode, expireDate: expireDate, originalText: originalText)
        
        return coupon
    }
}
