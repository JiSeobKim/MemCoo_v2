//
//  CouponDetailViewController.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 05/12/2016.
//  Copyright © 2016 mino. All rights reserved.
//

import UIKit

class CouponDetailViewController: UIViewController, UINavigationControllerDelegate, UIGestureRecognizerDelegate {
    @IBOutlet weak var barcodeImg: UIImageView!
    @IBOutlet weak var barcode: UILabel!
    @IBOutlet weak var expireDate: UILabel!
    @IBOutlet weak var finishButtonOutlet: UIButton!
    @IBOutlet weak var logoImage: UIImageView!
    
    //쿠폰뷰콘트롤러에서 받는 couponToDetail과 쿠폰애드뷰콘트롤러에 전달해주는 couponToEdit이 있다.
    var couponToDetail: Coupon?
    
    var titleName: String?
    var originalText: String?
    var originalImage: UIImage?
    
    //밝기 조절용
    var bright : CGFloat?
    
    @IBAction func finishButton(_ sender: UIButton) {
        let alert = UIAlertController(title: "사용 완료", message: "사용 완료하시겠습니까?", preferredStyle: .alert)
        let finish = UIAlertAction(title: "사용 완료", style: .destructive) {
            (_) in
            if self.couponToDetail != nil {
                self.couponToDetail?.isUsed = true
                ad.saveContext()
            }
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(finish)
        alert.addAction(cancel)
        self.present(alert, animated: true)
    }

    override func viewWillDisappear(_ animated: Bool) {
        ad.brightSwitch = false
        UIScreen.main.brightness = ad.bright!
        //화면이 사라질때 밝기 수정 off
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        if couponToDetail != nil {
            loadCouponData()
            self.navigationItem.title = titleName
            if couponToDetail?.isUsed == true {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                barcodeImg.isHidden = true
                barcode.text = "사용 완료"
                expireDate.isHidden = true
                finishButtonOutlet.isHidden = true
            }
        }
        
        //밝기 제스쳐 적용
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.pan(recognizer:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        self.view.addGestureRecognizer(panGesture)

       
        if let coupon = couponToDetail {
            self.navigationItem.title = coupon.title
        }
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
                
        //사용 완료 테두리
        finishButtonOutlet.layer.borderWidth = 1
        finishButtonOutlet.layer.borderColor = UIColor(red: 222/255.0, green: 222/255.0, blue: 222/255.0, alpha: 1.0).cgColor
        finishButtonOutlet.layer.cornerRadius = 10
        
        //raw data가 없을 때 버튼 숨김.
        if originalText == "" {
            self.navigationItem.rightBarButtonItems?[1].isEnabled = false
        }
       
    }
    
    //밝기 제스쳐
    func pan(recognizer:UIPanGestureRecognizer){
        if recognizer.state == UIGestureRecognizerState.changed || recognizer.state == UIGestureRecognizerState.ended {
            let velocity:CGPoint = recognizer.velocity(in: self.view)
            
            if velocity.y > 0{
                var brightness: Float = Float(UIScreen.main.brightness)
                brightness = brightness - 0.03
                UIScreen.main.brightness = CGFloat(brightness)
            }
            else {
                var brightness: Float = Float(UIScreen.main.brightness)
                brightness = brightness + 0.03
                UIScreen.main.brightness = CGFloat(brightness)
            }
        }
    }

    
    //아이템 데이타를 로드하는 펑션
    func loadCouponData() {
        if let coupon = couponToDetail {
            barcode.text = addHyphen(data: coupon.barcode!)
            barcodeImg.image = generateBarcodeFromString(string: coupon.barcode)
            expireDate.text = displayTheDate(theDate: coupon.expireDate as! Date)
            logoImage.image = coupon.toImage?.image as! UIImage?
            titleName = coupon.title
            originalText = coupon.originalText
            originalImage = coupon.image as! UIImage?
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
        
        if segue.identifier == "RawData" {
            if let destination = segue.destination as? CouponRawDataViewController {
                if originalText != "" {
                    print("\(originalText)")
                    destination.originalText = originalText
                }
                
                if originalImage != nil {
                    destination.originalImage = originalImage
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if couponToDetail != nil {
            loadCouponData()
            if couponToDetail?.isUsed == true {
                self.navigationItem.rightBarButtonItem?.isEnabled = false
                barcodeImg.isHidden = true
                barcode.text = "사용 완료"
                expireDate.isHidden = true
                finishButtonOutlet.isHidden = true
            }
        }
        //자동 밝기 최대
        
        let userData = UserDefaults.standard
        let brightOnOffData = userData.object(forKey: "Bright") as? Bool
        
        if brightOnOffData == true {
            UIScreen.main.brightness = 1.0
            ad.brightSwitch = true
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
