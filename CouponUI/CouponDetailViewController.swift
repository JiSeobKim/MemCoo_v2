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
    @IBOutlet weak var expireDate: UILabel!
    @IBOutlet weak var category: UILabel!
    @IBAction func finishButton(_ sender: Any) {
        //self.navigationItem.rightBarButtonItem
    }
    
    //쿠폰뷰콘트롤러에서 받는 couponToDetail과 쿠폰애드뷰콘트롤러에 전달해주는 couponToEdit이 있다.
    var couponToDetail: Coupon?
    var titleName: String?
    
    //밝기 조절용
    var bright : CGFloat?

    override func viewDidLoad() {
        super.viewDidLoad()

        if couponToDetail != nil {
            loadCouponData()
            self.navigationItem.title = titleName
        }
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        //밝기 최대
        UIScreen.main.brightness = 1.0

    }
    
    //아이템 데이타를 로드하는 펑션
    func loadCouponData() {
        
        if let coupon = couponToDetail {
            barcode.text = coupon.barcode
            barcodeImg.image = generateBarcodeFromString(string: coupon.barcode)
            expireDate.text = displayTheDate(theDate: coupon.expireDate as! Date) + " 까지"
            //originalText.text = coupon.originalText
            titleName = coupon.title
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CouponEditVC" {
            if let destination = segue.destination as? CouponAddViewController{
                destination.couponToEdit = couponToDetail
                ad.isAddButton = false
                
                if bright != nil {
                    destination.bright = self.bright
                }
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
