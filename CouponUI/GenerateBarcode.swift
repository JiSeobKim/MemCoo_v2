//
//  GenerateBarcode.swift
//  CouponUI
//
//  Created by mino on 2016. 12. 3..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit

    func generateBarcodeFromString(string: String?) -> UIImage? {
        let data = string?.data(using: String.Encoding.ascii)
        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)
            
            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }
        
        return nil
    }

