//
//  CouponDetailViewController.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 05/12/2016.
//  Copyright © 2016 mino. All rights reserved.
//

import UIKit

class CouponDetailViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet weak var barcodeImg: UIImageView!
    @IBOutlet weak var barcode: UILabel!
    @IBOutlet weak var expireDate: UITextField!
    @IBOutlet weak var category: UITextField!
    @IBOutlet weak var originalText: UITextView!
    
    
    //쿠폰뷰콘트롤러에서 받는 couponToDetail과 쿠폰애드뷰콘트롤러에 전달해주는 couponToEdit이 있다.
    var couponToDetail: Coupon?
    

    override func viewDidLoad() {
        super.viewDidLoad()

        if couponToDetail != nil {
            loadCouponData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    //pushTest 입니다 Jiseob
    
    //아이템 데이타를 로드하는 펑션
    func loadCouponData() {
        
        if let coupon = couponToDetail {
            barcode.text = coupon.barcode
            barcodeImg.image = generateBarcodeFromString(string: coupon.barcode)
            expireDate.text = displayTheDate(theDate: coupon.expireDate as! Date)
            originalText.text = coupon.originalText
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CouponEditVC" {
            if let destination = segue.destination as? CouponAddViewController{
                destination.couponToEdit = couponToDetail
            }
        }
            
    }
    override func viewWillAppear(_ animated: Bool) {
        if couponToDetail != nil {
            loadCouponData()
        }
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destinationViewController.
     // Pass the selected object to the new view controller.
     }
     */
}
