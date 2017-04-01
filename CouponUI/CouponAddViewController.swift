//
//  CouponAddViewController.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 05/12/2016.
//  Copyright © 2016 mino. All rights reserved.
//

import UIKit
import TesseractOCR

class CouponAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, G8TesseractDelegate, UITextViewDelegate {
    var imagePicker: UIImagePickerController!

    //detail에서 넘어온 coupon 객체를 받기하기 위한 coupon 객체
    var couponToEdit: Coupon?
    
    //밝기 조절용
    var bright : CGFloat?
    
    @IBOutlet weak var logo: UIImageView!
    //로고 선택 시 버튼 숨기기 위한 변수.
    @IBOutlet weak var logoButton: UIButton!
    var originalImage: UIImage?
    
    @IBOutlet weak var deleteOutlet: UIBarButtonItem!
    
    //데이터베이스에서 삭제
    @IBAction func deleteButton(_ sender: Any) {
        let alert = UIAlertController(title: "쿠폰 삭제", message: "쿠폰을 삭제하시겠습니까?", preferredStyle: .alert)
        alert.view.tintColor = UIColor.black
        
        let delete = UIAlertAction(title: "삭제", style: .destructive) {
            (_) in
            if self.couponToEdit != nil {
                context.delete(self.couponToEdit!)
                ad.saveContext()
            }
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        alert.addAction(delete)
        alert.addAction(cancel)
        self.present(alert, animated: true)
        
    }

    @IBOutlet weak var product: UITextField!
    @IBOutlet weak var barcode: UITextField!
    
    //barcode 실시간으로 보여주기 위한 액션
    @IBAction func createdBarcodeImg(_ sender: UITextField) {
        barcodeImg.image = generateBarcodeFromString(string: barcode.text!)
    }

    @IBOutlet weak var barcodeImg: UIImageView!
    @IBOutlet weak var expiredDate: UITextField!
    
    //유효기간 텍스트필드 클릭시 데이트 픽커를 이용한 날짜 선택하기 액션
    @IBAction func expiredDateFieldBegin(_ sender: UITextField) {
        let datePicker: UIDatePicker = UIDatePicker()
        datePicker.backgroundColor = UIColor(white: 0.5, alpha: 0.8)
        datePicker.setValue(UIColor.white, forKey: "textColor")
        datePicker.datePickerMode = .date
        sender.inputView = datePicker
        datePicker.addTarget(self, action: #selector(CouponAddViewController.datePickerValueChanged), for: UIControlEvents.valueChanged)
    }
    
    @IBAction func expiredDateFieldEnd(_ sender: UITextField) {
        
        if expiredDate.text == ""{
            let todaysDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            expiredDate.text = dateFormatter.string(from: todaysDate)
            
        }
    }
    
    //타겟시 데이트피커의 값을 텍스트 필드에 넣어주기 위한 펑션
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        expiredDate.text = dateFormatter.string(from: sender.date)
    }

    @IBOutlet weak var originalText: UITextView!
    
    //모든 값을 코어데이터 테이블로 저장하기 위한 액션
    @IBAction func saveBtnPressed(_ sender: UIBarButtonItem) {
        var coupon: Coupon!
        let imageContext = Image(context: context)
        
        //입력되지 않은 부분이 있을 때에는 알림창, 모두 입력되었을 때에는 저장.
        if product.text == "" {
            product.attributedPlaceholder = NSAttributedString(string: "입력해 주세요.", attributes: [NSForegroundColorAttributeName: UIColor.purple])
        }
        
        if expiredDate.text == "" {
            expiredDate.attributedPlaceholder = NSAttributedString(string: "입력해 주세요.", attributes: [NSForegroundColorAttributeName: UIColor.purple])
        }
        
        if barcode.text == "" {
            barcode.attributedPlaceholder = NSAttributedString(string: "입력해 주세요.", attributes: [NSForegroundColorAttributeName: UIColor.purple])
        }
        
        if product.text != "" && expiredDate.text != "" && barcode.text != "" {
            //itemToEdit이 nil일 경우 새로운 객체를 전달해서 저장 아닐경우 그 itemToEdit으로 저장
            if couponToEdit == nil {
                coupon = Coupon(context: context)
                coupon.isUsed = false
                coupon.favorite = false
            }
            else {
                coupon = couponToEdit
            }
        
            //logo 담기!
            if let logoImg = logo.image {
                imageContext.image = logoImg
                coupon.toImage = imageContext
            }
        
            //상품명 담기!
            if let title = product.text {
                coupon.title = title
            }
        
            //바코드번호 담기!
            if let barcode = barcode.text {
                coupon.barcode = barcode
            }
        
            //유효기간 담기
            if let expiredDate = expiredDate.text{
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd"
                let date = formatter.date(from: expiredDate)
                if date != nil {
                    coupon.expireDate = date as NSDate?
                }
            }
        
            //원본 이미지 담기
            if let originalImage = originalImage {
                coupon.image = originalImage
            }
        
            //메모 담기
            if let memo = originalText.text {
                coupon.originalText = memo
            }
        
            ad.saveContext()
            _ = self.navigationController?.popToRootViewController(animated: true)
        }
    }
    
    //Coupon 데이타를 로드하는 펑션
    func loadCouponData() {
        if let coupon = couponToEdit {
            product.text = coupon.title
            barcode.text = coupon.barcode
            barcodeImg.image = generateBarcodeFromString(string: barcode.text)
            expiredDate.text = displayTheDate(theDate: coupon.expireDate as! Date)
            logo.image = coupon.toImage?.image as? UIImage
            originalText.text = coupon.originalText
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        originalText.delegate = self
        
        var parsingBrain: ParsingBrain
        var couponInfo: ParsingBrain.CouponInfo
        
        //다른 곳 터치시 키보드 제거 및 프레임 원위치
        self.hideKeyboardWhenTappedAround()
        
        //툴바
        addInputAccessoryForTextFields(textFields: [product, barcode, expiredDate],dismissable: true, previousNextable: true)
        addInputAccessoryForTextViews(textViews: [originalText], dismissable: true, previousNextable: true)
        
        //add 버튼을 눌렀을 때.
        if ad.isAddButton == true {
            self.navigationItem.title = "쿠폰 추가"
            
            //상품명 텍스트 필드를 최초 응답자로 지정(스토리보드 내에서 dock을 이용해도 가능).
            self.product.becomeFirstResponder()
            
            //추가 상태일 때에는 삭제 버튼 숨김.
            deleteOutlet.isEnabled = false
            deleteOutlet.tintColor = UIColor.white
            
            //클립보드 파싱 버튼을 눌렀을 때 자동으로 텍스트필드 입력.
            if ad.clipboardActionSheet == 1 {
                parsingBrain = ParsingBrain()
                
                if let copiedString = UIPasteboard.general.strings {
                    couponInfo = parsingBrain.parsing(textFromClipboard: copiedString)
                    product.text = couponInfo.title
                    expiredDate.text = couponInfo.expireDate
                    barcode.text = couponInfo.barcode
                    originalText.text = copiedString.first
                }
            }
            //OCR 버튼을 눌렀을 때 이미지 OCR 후 바코드만 입력.
            else if ad.clipboardActionSheet == 2 {
                if let tesseract = G8Tesseract(language: "eng+kor") {
                    tesseract.delegate = self
                    tesseract.image = originalImage?.g8_grayScale() //.g8_blackAndWhite()
                    tesseract.recognize()
                    originalText.text = tesseract.recognizedText
                }
            }
            //직접 입력 시.
            else if ad.clipboardActionSheet == 3 {
                originalText.text = ""
            }
        }
        //수정 버튼을 눌렀을 때.
        else {
            self.navigationItem.title = "쿠폰 수정"
            loadCouponData()
        }
        
        if let topItem = self.navigationController?.navigationBar.topItem {
            topItem.backBarButtonItem = UIBarButtonItem(title: "", style: UIBarButtonItemStyle.plain, target: nil, action: nil)
        }
        
        logoButton.setImage(MemcooView.imageOfLogoSelectButton(), for: .normal)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //로고데이타 받아오기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "logoSelect2" {
            (segue.destination as? logoSelect)?.delegate = self
        }
    }
    //메모 선택시 프레임 이동
    func textViewDidBeginEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.25, animations: {
             self.view.frame.origin.y -= 200
        }, completion: nil)
       
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        UIView.animate(withDuration: 0.15, animations: {
            self.view.frame.origin.y += 200
        }, completion: nil)
    }
    
    // 복분으로 인한 문자 입력 방지 및 여백 삭제
    @IBAction func codeTextField(_ sender: Any) {
        barcode.text = numParsing(barcode.text!)
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


//extension 부분
extension CouponAddViewController : logoData {
    
    func updataData(data: UIImage) {
        logo.image = data
    }
    
}
