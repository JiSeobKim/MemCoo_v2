//
//  CouponAddViewController.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 05/12/2016.
//  Copyright © 2016 mino. All rights reserved.
//

import UIKit
import TesseractOCR

class CouponAddViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, G8TesseractDelegate {
    var imagePicker: UIImagePickerController!

    //detail에서 넘어온 coupon 객체를 받기하기 위한 coupon 객체
    var couponToEdit: Coupon?
    
    //밝기 조절용
    var bright : CGFloat?
    
    @IBOutlet weak var logo: UIImageView!
    
    //데이터베이스에서 삭제
    @IBAction func deletePressed(_ sender: UIButton) {
        let alert = UIAlertController(title: "삭제하시겠습니까?", message: "한 번 삭제한 쿠폰은 복구할 수 없습니다!", preferredStyle: .alert)
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
    
    //버튼 숨김 기능을 위한 버튼 아울렛.
    @IBOutlet weak var deleteButton: UIButton!
   
//    //로고를 선택하면 데이터베이스의 로고를 불러오기 위한 버튼액션(현재는 사진첩으로 가게해놓음)
//    @IBAction func picturePickerPressed(_ sender: UIButton) {
//        present(imagePicker, animated: true, completion: nil)
//    }
    
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
//        if let img = info[UIImagePickerControllerOriginalImage] as? UIImage{
//            logo.image = img
//        }
//        imagePicker.dismiss(animated: true, completion: nil)
//    }
    
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
    
    //타겟시 데이트피커의 값을 텍스트 필드에 넣어주기 위한 펑션
    func datePickerValueChanged(sender: UIDatePicker) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        expiredDate.text = dateFormatter.string(from: sender.date)
    }

    //카테고리 필드 클릭시 여태까지 만들어 놓았던 카테고리를 픽커뷰로 보여주기 위한 액션
    @IBAction func categoryFieldPressed(_ sender: UITextField) {
    }

    @IBOutlet weak var originalText: UITextView!
    
    //모든 값을 코어데이터 테이블로 저장하기 위한 액션
    @IBAction func saveBtnPressed(_ sender: UIBarButtonItem) {
        var coupon: Coupon!
        let ImageContext = Image(context: context)
        
        //입력되지 않은 부분이 있을 때에는 알림창, 모두 입력되었을 때에는 저장.
        if product.text == "" {
            let alert = UIAlertController(title: "오류", message: "상품명을 입력해 주세요.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
        else if expiredDate.text == "" {
            let alert = UIAlertController(title: "오류", message: "쿠폰 번호를 입력해 주세요.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
        else if barcode.text == "" {
            let alert = UIAlertController(title: "오류", message: "유효 기간을 입력해 주세요.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .cancel)
            alert.addAction(ok)
            self.present(alert, animated: true)
        }
        else {
        //itemToEdit이 nil일 경우 새로운 객체를 전달해서 저장 아닐경우 그 itemToEdit으로 저장
        if couponToEdit == nil {
            coupon = Coupon(context: context)
            coupon.isUsed = false
            coupon.favorite = false
        } else {
            coupon = couponToEdit
        }
        
        //logo 담기!
        if let logoImg = logo.image {
            ImageContext.image = logoImg
            coupon.toImage = ImageContext
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
        
        var parsingBrain: ParsingBrain
        var couponInfo: ParsingBrain.CouponInfo
        
        //상품명 텍스트 필드를 최초 응답자로 지정(스토리보드 내에서 dock을 이용해도 가능).
        if ad.isAddButton == true {
            self.product.becomeFirstResponder()
        }
        //화면 전환시 입력창 바로 반응
        
//        imagePicker = UIImagePickerController()
//        imagePicker.delegate = self
        if couponToEdit != nil {
            loadCouponData()
        }
        
        //add 버튼을 눌렀을 때 타이틀과 버튼 이름 변경.
        if ad.isAddButton == true {
            self.navigationItem.title = "쿠폰 추가"
            //추가 상태일 때에는 삭제 버튼 숨김.
            deleteButton.isHidden = true
            
            //클립보드 파싱 버튼을 눌렀을 때 자동으로 텍스트필드 입력.
            if ad.isClipboardActionSheet == true {
                parsingBrain = ParsingBrain()
                if let copiedString = UIPasteboard.general.strings {
                    couponInfo = parsingBrain.parsing(textFromClipboard: copiedString)
                    product.text = couponInfo.title
                    expiredDate.text = couponInfo.expireDate
                    barcode.text = couponInfo.barcode
                    originalText.text = copiedString[0]
                }
            }
            //OCR 버튼을 눌렀을 때 이미지 OCR 후 바코드만 입력.
            else if ad.isClipboardActionSheet == false {
//                //파싱 퍼센트 표시 알림창.
//                func progressImageRecognition(for tesseract: G8Tesseract!) {
//                    let progress = UIAlertController(title: "알림", message: "Recognition Progress: \(tesseract.progress)%", preferredStyle: UIAlertControllerStyle.alert)
//                    self.present(progress, animated: true)
//                
//                    if tesseract.progress >= 90 {
//                        self.dismiss(animated: true)
//                    }
//                }
                
//                if let tesseract = G8Tesseract(language: "eng+kor") {
//                    tesseract.delegate = self
//                    //tesseract.charWhitelist = "0123456789"
//                    tesseract.image = UIImage(named: "gifticon_cu")?.g8_grayScale()    //.g8_blackAndWhite()
//                    tesseract.recognize()
//                    
//                    parsingOCR = ParsingOCR()
//                    OCRCouponInfo = parsingOCR.parsing(textFromClipboard: tesseract.recognizedText)
//                    barcode.text = OCRCouponInfo.barcode
//                    originalText.text = OCRCouponInfo.originalText
//                }
            }
        }
        //수정 버튼을 눌렀을 때 타이틀과 버튼 이름 변경.
        else {
            self.navigationItem.title = "쿠폰 수정"
            loadCouponData()
        }
        
        //로고 탭했을 때 로고 뷰 보여주기.
        //        var imageView = logoImage
        //        let tapGestureRecoginzer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(img:)))
        //        imageView?.isUserInteractionEnabled = true
        //        imageView?.addGestureRecognizer(tapGestureRecoginzer)
        //
        //        func imageTapped(img: AnyObject) {
        //            //
        //        }
        
        //클립보드 표시.
//        if let copiedString = UIPasteboard.general.string {
//            originalText.text = copiedString
//        }
        
        //키보드 위에 버튼 표시.
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.barStyle = .default
        keyboardToolbar.isTranslucent = true
        keyboardToolbar.sizeToFit()
        
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.done, target: self, action: #selector(self.doneClicked))
        //let nextBarButton = UIBarButtonItem(image: UIImage(named: "keyboardPreviousButton"), style: .plain, target: self, action: "")
        keyboardToolbar.setItems([flexibleSpace, doneBarButton], animated: true)
        
        product.inputAccessoryView = keyboardToolbar
        barcode.inputAccessoryView = keyboardToolbar
        expiredDate.inputAccessoryView = keyboardToolbar
        originalText.inputAccessoryView = keyboardToolbar
        
        //키보드 크기만큼 뷰를 위로 이동.
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    //OCR
    override func viewDidAppear(_ animated: Bool) {
        var parsingOCR: ParsingOCR
        var OCRCouponInfo: ParsingOCR.CouponInfo
        
        if ad.isAddButton == true && ad.isClipboardActionSheet == false {
            if let tesseract = G8Tesseract(language: "eng+kor") {
                tesseract.delegate = self
                //tesseract.charWhitelist = "0123456789"
                tesseract.image = UIImage(named: "gifticon_cu")?.g8_grayScale()    //.g8_blackAndWhite()
                tesseract.recognize()
            
                parsingOCR = ParsingOCR()
                OCRCouponInfo = parsingOCR.parsing(textFromClipboard: tesseract.recognizedText)
                barcode.text = OCRCouponInfo.barcode
                originalText.text = OCRCouponInfo.originalText
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //파싱 퍼센트 표시 알림창.
        if ad.isAddButton == true && ad.isClipboardActionSheet == false {
            func progressImageRecognition(for tesseract: G8Tesseract!) {
                let progress = UIAlertController(title: "알림", message: "Recognition Progress: \(tesseract.progress)%", preferredStyle: UIAlertControllerStyle.alert)
                self.present(progress, animated: true)
            
                if tesseract.progress >= 90 {
                    self.dismiss(animated: true)
                }
            }
        }
    }
    
    
    //키보드 위에 버튼 표시.
    func doneClicked() {
        view.endEditing(true)
    }
    
    //키보드 크기만큼 뷰를 위로 이동.
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y != 0 {
                self.view.frame.origin.y += keyboardSize.height
            }
        }
    }
    
    //파싱 퍼센트 표시.
    func progressImageRecognition(for tesseract: G8Tesseract!) {
        print("Recognition Progress \(tesseract.progress)%")
    }
    
//    //사진 앱 접근을 위한 메소드.
//    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
//        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
//            logo.image = image
//        }
////        imagePicker.dismiss(animated: true, completion: nil)
//        self.dismiss(animated: true, completion: nil)
//    }
//    
//    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
//        self.dismiss(animated: true, completion: nil)
//    }
    
    //텍스트 필드가 아닌 곳을 터치했을 때 키보드 닫기.
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        product.resignFirstResponder()
        barcode.resignFirstResponder()
        expiredDate.resignFirstResponder()
        originalText.resignFirstResponder()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func favorite(_ sender: UIButton) {
        if let coupon = couponToEdit{
            coupon.favorite = true
            ad.saveContext()
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


////extension 부분
//
//extension CouponAddViewController : logoData {
//    
//    func updataData(data: UIImage) {
//        
//        logo.image = data
//        
//    }
//    
//}
