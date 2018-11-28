//
//  SettingsTableViewController.swift
//  MemebershipCoupon
//
//  Created by mino on 2017. 1. 7..
//  Copyright © 2017년 mino. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications
import StoreKit

class SettingsTableViewController: UITableViewController, UIPickerViewDataSource, UIPickerViewDelegate, NSFetchedResultsControllerDelegate, SKPaymentTransactionObserver, SKProductsRequestDelegate{
    var titleName: String?
    var expireDate: NSDate?
    var controller: NSFetchedResultsController<Coupon>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        attemptFetch()
        
        self.parent?.view.backgroundColor = .white
        
        //퍼미션 요청(iOS 10 이상).
//        let center = UNUserNotificationCenter.current()
//        center.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: {didAllow, error in})
        
        //퍼미션 요청.
        let app = UIApplication.shared
        let notificationSettings = UIUserNotificationSettings(types: [.alert, .sound, .badge], categories: nil)
        app.registerUserNotificationSettings(notificationSettings)
        
        //다른 곳 터치시 키보드 제거 및 프레임 원위치
        self.hideKeyboardWhenTappedAround()
        
        //날짜 피커뷰 설정.
        let datePickerView: UIPickerView = UIPickerView()
        datePickerView.delegate = self
        notiDate.inputView = datePickerView
        
        addInputAccessoryForTextFields(textFields: [notiDate], dismissable: true, previousNextable: true)//                datePickerView.backgroundColor = UIColor(white: 0.5, alpha: 0.8)
//                datePickerView.setValue(UIColor.white, forKey: "textColor")
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        ///// IAP Part.
        btnOutWater.isEnabled = false
        btnOutCoffee.isEnabled = false
        btnOutAlcohol.isEnabled = false
        btnOutFood.isEnabled = false
        btnOutRestore.isEnabled = false
        
        fetchAvailableProducts()
        
        
        
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickDay.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickDay[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        notiDate.text = pickDay[row]
    }

    override func viewWillAppear(_ animated: Bool) {
        let userData = UserDefaults.standard
        let brightOnOffData = userData.object(forKey: "BrightOff") as? Bool
        if brightOnOffData != nil {
            if brightOnOffData == true {
                brightOutlet.setOn(false, animated: false)
            } else {
                brightOutlet.setOn(true, animated: false)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //자동 밝기
    let brightdata = UserDefaults.standard
    @IBOutlet weak var brightOutlet: UISwitch!
    @IBAction func brightSwitch(_ sender: UISwitch) {
        
        if brightOutlet.isOn {
            brightdata.set(false, forKey: "BrightOff")
            
        } else {
            brightdata.set(true, forKey: "BrightOff")
            
        }
    }
    
    //알림 스위치 아웃렛.
    @IBOutlet weak var notiOutlet: UISwitch!
    
    //알림 스위치 메서드.
    @IBAction func notiSwitch(_ sender: Any) {
        if notiOutlet.isOn == true {
        }
        else {
        }
    }
    
    @IBOutlet weak var notiDate: UITextField!
    let pickDay = ["0","1", "2", "3", "4", "5", "6", "7"]
    
    @IBAction func notiSender(_ sender: Any) {
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        
        var titleArray: [String?] = []
        var expireDateArray: [NSDate?] = []
        
        if notiDate.text == "" {
            notiDate.text = "0"
        }
        
        if let objs = controller.fetchedObjects, objs.count > 0 {   //objs: Coupon 타입 배열.
            for (i, item) in objs.enumerated() {
                titleArray.append(item.title)
                expireDateArray.append(item.expireDate)
                print("objs[\(i)] = \(String(describing: titleArray[i])), \(String(describing: expireDateArray[i]))")
            }
        }
        
        let strInt = Int(notiDate.text!)
        let timeInterval = -(strInt!)*(24*60*60)
        var beforeDate: [NSDate] = []
        
        for (i, date1) in expireDateArray.enumerated() {
            //let date1 = expireDateArray[i]!
            let date2: TimeInterval = TimeInterval(timeInterval)
            beforeDate.append(NSDate(timeInterval: date2, since: date1! as Date))
            print("\(beforeDate[i])")
            
            //로컬 알림.
            let content = UNMutableNotificationContent()
            content.body = "\"\(titleArray[i]!)\" 쿠폰의 사용 기간이 \(notiDate.text!)일 남았습니다."
            content.sound = UNNotificationSound.default
            content.badge = 0
            
            //테스트 코드.
            //          var dateMatching = DateComponents()
            //          dateMatching.year = 2017
            //          dateMatching.month = 4
            //          dateMatching.day = 1
            //          dateMatching.hour = 4
            //          dateMatching.minute = 54
            //          print("\(dateMatching)")
            //          let trigger = UNCalendarNotificationTrigger(dateMatching: dateMatching, repeats: false)
            
            //실제 코드.
            let cal = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)
            let dateMatching = cal?.components([.year, .month, .day, .hour, .minute], from: beforeDate[i] as Date)
            print("\(dateMatching!)")
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateMatching!, repeats: false)
            let request = UNNotificationRequest(identifier: "timerDone", content: content, trigger: trigger)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
        }
        
        //알림 설정 내용을 확인.
        //        let setting = UIApplication.shared.currentUserNotificationSettings
        //
        //        if setting?.types == .none {
        //            let alert = UIAlertController(title: "알림 등록", message: "알림이 허용되어 있지 않습니다.", preferredStyle: .alert)
        //            let ok = UIAlertAction(title: "확인", style: .default)
        //            alert.addAction(ok)
        //            self.present(alert, animated: false)
        //        }
        //
        //        if notificationOutlet.isOn == true {
        //            if #available(iOS 10.0, *) {
        //                //UserNotifications 프레임워크를 사용한 로컬 알림.
        //                //알림 컨텐츠 정의.
        //                let nContent = UNMutableNotificationContent()
        //                nContent.title = "미리 알림"
        //                nContent.body = "\(titleName!) 쿠폰의 사용 기한이 일주일 남았습니다."
        //                nContent.sound = UNNotificationSound.default()
        //
        //                //발송 시각을 "지금으로부터 *초 형식"으로 변환
        //                let timeInterval = expireDate?.timeIntervalSinceNow
        //                print(timeInterval!)
        //
        //                //발송 조건 정의.
        //                let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval!, repeats: false)
        //
        //                //발송 요청 객체 정의.
        //                let request = UNNotificationRequest(identifier: "alarm", content: nContent, trigger: trigger)
        //
        //                //노티피케이션 센터에 추가.
        //                UNUserNotificationCenter.current().add(request)
        //            }
        //            else {
        //                //LocalNotification 객체를 사용한 로컬 알림.
        //            }
        //        }

    }
    
    //coreData 부분
    //패치해오는 펑션
    func attemptFetch() {
        let fetchRequest: NSFetchRequest<Coupon> = Coupon.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        fetchRequest.sortDescriptors = [dateSort]
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        //save시 tableview update를 위한 델리게이트 전달
        controller.delegate = self
        self.controller = controller
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
        
    }
    
    //컨트롤러가 바뀔때마다 테이블뷰 업데이트
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    
    
    //IAP Part.
    @IBOutlet weak var labelWater: UILabel!
    @IBOutlet weak var labelCoffee: UILabel!
    @IBOutlet weak var labelAlcohol: UILabel!
    @IBOutlet weak var labelFood: UILabel!

    
    @IBOutlet weak var btnOutWater: UIButton!
    @IBOutlet weak var btnOutCoffee: UIButton!
    @IBOutlet weak var btnOutAlcohol: UIButton!
    @IBOutlet weak var btnOutFood: UIButton!
    @IBOutlet weak var btnOutRestore: UIButton!
    
    
    
    //제품 이름
    let WATER_ID = "com.MemCoo.Water2"
    let COFFEE_ID = "com.MemCoo.Coffee2"
    let ALCOHOL_ID = "com.MemCoo.Alcohol2"
    let FOOD_ID = "com.MemCoo.Food2"
    
    //변수
    var iapProducts = [SKProduct]()
    
    func fetchAvailableProducts() {
        let productIdentifiers = NSSet(objects: WATER_ID, COFFEE_ID, ALCOHOL_ID, FOOD_ID)
        
        let productsRequest = SKProductsRequest(productIdentifiers: productIdentifiers as! Set<String>)
        
        productsRequest.delegate = self
        productsRequest.start()
    }
    
    
    //불러온 것들 표기
    func productsRequest(_ request: SKProductsRequest, didReceive response: SKProductsResponse) {
        iapProducts = response.products
        for product in iapProducts {
            print("Product Added")
            print(product.productIdentifier)
            print(product.price)
        }
        btnOutWater.isEnabled = true
        btnOutCoffee.isEnabled = true
        btnOutAlcohol.isEnabled = true
        btnOutFood.isEnabled = true
        btnOutRestore.isEnabled = true
        
    }
    
    func purchaseMyProduct(product: SKProduct) {
        if SKPaymentQueue.canMakePayments() {
            let payment = SKPayment(product: product)
            SKPaymentQueue.default().add(self)
            SKPaymentQueue.default().add(payment)
            
            print("PRODUCT TO PURCHASE : \(product.productIdentifier)")
            
        }
    }
    
    func paymentQueueRestoreCompletedTransactionsFinished(_ queue: SKPaymentQueue) {
        print("transaction restored")
        for transaction in queue.transactions {
            let t : SKPaymentTransaction = transaction
            let prodID = t.payment.productIdentifier as String
            switch prodID {
            case WATER_ID :
                productFunction(product: "water")
                break;
                
            case COFFEE_ID :
                productFunction(product: "coffee")
                break;
                
            case ALCOHOL_ID:
                productFunction(product: "alcohol")
                break;
                
            case FOOD_ID :
                productFunction(product: "food")
                break;
                
            default:
                
                break;
                
            }
        }
    }
    
    //버튼
    @IBAction func btnBuyWater(_ sender: UIButton) {
        for product in iapProducts {
            let prodID = product.productIdentifier
            if(prodID == WATER_ID) {
                purchaseMyProduct(product: product)
            }
        }
        
    }
    @IBAction func btnBuyCoffee(_ sender: UIButton) {
        for product in iapProducts {
            let prodID = product.productIdentifier
            if(prodID == COFFEE_ID) {
                purchaseMyProduct(product: product)
            }
        }
        
        
    }
    @IBAction func btnBuyAlcohol(_ sender: UIButton) {
        for product in iapProducts {
            let prodID = product.productIdentifier
            if(prodID == ALCOHOL_ID) {
                purchaseMyProduct(product: product)
            }
        }
        
    }
    @IBAction func btnBuyFood(_ sender: UIButton) {
        for product in iapProducts {
            let prodID = product.productIdentifier
            if(prodID == FOOD_ID) {
                purchaseMyProduct(product: product)
            }
        }
        
    }
    @IBAction func btnRestore(_ sender: UIButton) {
        SKPaymentQueue.default().add(self)
        SKPaymentQueue.default().restoreCompletedTransactions()
        
    }
    
    
    //실제 기능
    func productFunction(product:String){
        switch product {
        case "water" :
            createAlert(titleText: "잘 마시겠습니다!", messageText: "꿀꺽꿀꺽")
            break;
            
        case "coffee" :
            createAlert(titleText: "잘 마시겠습니다!", messageText: "아메리카노!")
            break;
            
        case "alcohol" :
            createAlert(titleText: "잘 취하겠습니다!", messageText: "크~")
            break;
            
        case "food" :
            createAlert(titleText: "잘 먹겠습니다", messageText: "냠냠")
            break;
            
        default:
            break;
            
        }
    }
    
    //알림 펑션
    func createAlert(titleText : String, messageText : String) {
        let alert = UIAlertController(title: titleText, message: messageText, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "감사합니다", style: .default, handler: {(action) in alert.dismiss(animated:true, completion: nil) }))
        self.present(alert, animated: true,completion:  nil)
    }

    
    
    //실제 구매시 처리과정
    func paymentQueue(_ queue: SKPaymentQueue, updatedTransactions transactions: [SKPaymentTransaction]) {
        for transaction:AnyObject in transactions {
            if let trans = transaction as? SKPaymentTransaction {
                
                
                switch trans.transactionState {
                case .purchased:
                    
                    print("purchase")
                    SKPaymentQueue.default().finishTransaction(transaction as! SKPaymentTransaction)
                    
                    for transaction in queue.transactions {
                        let t : SKPaymentTransaction = transaction
                        let prodID = t.payment.productIdentifier as String
                        switch prodID {
                        case WATER_ID :
                            print("BuyWater")
                            productFunction(product: "water")
                            break;
                        case COFFEE_ID :
                            print("BuyCoffee")
                            productFunction(product: "coffee")
                            break;
                            
                        case ALCOHOL_ID :
                            print("BuyAlcohol")
                            productFunction(product: "alcohol")
                            break;
                            
                        case FOOD_ID :
                            print("BuyFood")
                            productFunction(product: "food")
                            break;
                            
                        default:
                            print("IAP not found")
                            break;
                            
                        }
                    }
                    
                case .failed:
                    print("fail")
                    break;
                    
                default :
                    print("Default")
                    break
                    
                    
                    
                }
            }
        }
    }
    
    
    
    
    
    
    
    
    
    
}
