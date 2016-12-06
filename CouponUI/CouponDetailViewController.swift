//
//  CouponDetailViewController.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 05/12/2016.
//  Copyright © 2016 mino. All rights reserved.
//

import UIKit

class CouponDetailViewController: UIViewController, UINavigationControllerDelegate {
    
    //쿠폰뷰콘트롤러에서 받는 couponToDetail과 쿠폰애드뷰콘트롤러에 전달해주는 couponToEdit이 있다.
    var couponToDetail: Coupon?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
