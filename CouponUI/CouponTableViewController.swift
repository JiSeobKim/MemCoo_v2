////
////  CouponTableViewController.swift
////  CouponUI
////
////  Created by mino on 2016. 12. 3..
////  Copyright © 2016년 mino. All rights reserved.
////
//
//import UIKit
//
//class CouponTableViewController: UITableViewController {
//    @IBAction func addButton(_ sender: Any) {
//        let alert = UIAlertController(title: "쿠폰 추가", message: "쿠폰을 추가할 방식을 선택해주세요.", preferredStyle: .actionSheet)
//        
//        let clipboard = UIAlertAction(title: "클립보드 내용 자동 추가", style: .default)
//        
//        let ocr = UIAlertAction(title: "사진에서 바코드만 읽어오기", style: .default)
//        
//        let custom = UIAlertAction(title: "사용자 직접 입력", style: .default) {
//            (_) in
//            if let editVC = self.storyboard?.instantiateViewController(withIdentifier: "AddEdit") {
//                self.navigationController?.pushViewController(editVC, animated: true)
//            }
//        }
//        
//        let cancel = UIAlertAction(title: "취소", style: .cancel)
//        
//        alert.addAction(clipboard)
//        alert.addAction(ocr)
//        alert.addAction(custom)
//        alert.addAction(cancel)
//        
//        self.present(alert, animated: true)
//    }
//    
//    var ad = UIApplication.shared.delegate as? AppDelegate
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view, typically from a nib.
//    }
//    
//    override func viewWillAppear(_ animated: Bool) {
//        self.tableView.reloadData()
//    }
//    
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return (ad?.product.count)!
//    }
//    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "CouponTableViewCell") as! CouponTableViewCell
//        
//        cell.product.text = ad?.product[indexPath.row]
//        cell.expired.text = ad?.expired[indexPath.row]
//        cell.barcode.text = ad?.barcode[indexPath.row]
//        ad?.row = indexPath.row
//        
//        return cell
//    }
//    
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//}
