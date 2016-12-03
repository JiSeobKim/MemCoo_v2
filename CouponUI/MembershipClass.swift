//
//  struct.swift
//  UISample
//
//  Created by 김지섭 on 2016. 11. 22..
//  Copyright © 2016년 mino. All rights reserved.
//


import UIKit


let ad = UIApplication.shared.delegate as? AppDelegate

struct MembershipStruct {
    var brand : String?
    var user : String?
    var barcode : String?
    var logo : UIImage?
    var barcodeImage : UIImage?
    var favorite : Bool = false
    
    init(){
        self.brand = "Test"
        self.user = "Jiseob"
        self.barcode = "1323"
        self.logo = UIImage(named: "default")
        self.barcodeImage = UIImage(named: "barcode")
        self.favorite = false
        
    }
    
}


