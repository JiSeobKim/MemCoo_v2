//
//  SettingsTableViewController.swift
//  MemebershipCoupon
//
//  Created by mino on 2017. 1. 7..
//  Copyright © 2017년 mino. All rights reserved.
//

import UIKit
import UserNotifications

class SettingsTableViewController: UITableViewController {
    var couponToNoti: Coupon?
    var titleName: String?
    var expireDate: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        //네비 폰트
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "NanumSquare", size: 17)!]
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let userData = UserDefaults.standard
        let brightOnOffData = userData.object(forKey: "Bright") as? Bool
        if brightOnOffData != nil {
            if brightOnOffData == true {
                brightOutlet.setOn(true, animated: false)
            } else {
                brightOutlet.setOn(false, animated: false)
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
    @IBOutlet weak var brightOutlet: UISwitch!
    @IBAction func brightSwitch(_ sender: UISwitch) {
        let brightdata = UserDefaults.standard
        if brightOutlet.isOn {
            brightdata.set(true, forKey: "Bright")
            print("saveTrue")
        } else {
            brightdata.set(false, forKey: "Bright")
            print("saveFalse")
        }
    }
    
    //아이템 데이타를 로드하는 펑션
    func loadCouponData() {
        if let coupon = couponToNoti {
            titleName = coupon.title
            expireDate = coupon.expireDate
            //expireDate = displayTheDate(theDate: coupon.expireDate as! Date)
        }
    }
    
    //알림.
    @IBOutlet weak var notificationOutlet: UISwitch!
    @IBAction func notificationSwitch(_ sender: Any) {
//        //알림 설정 내용을 확인.
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
    
    // MARK: - Table view data source

    /* override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    } */

       /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
