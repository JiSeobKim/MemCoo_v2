////
////  AddEditCouponViewController.swift
////  CouponUI
////
////  Created by mino on 2016. 12. 3..
////  Copyright © 2016년 mino. All rights reserved.
////
//
//import UIKit
//
//class AddEditCouponViewController: UIViewController {
//    @IBOutlet weak var product: UITextField!
//    @IBOutlet weak var expired: UITextField!
//    @IBOutlet weak var barcode: UITextField!
//    
//    let ad = UIApplication.shared.delegate as? AppDelegate
//    
//    @IBAction func addEditButton(_ sender: Any) {
//        ad?.product.append(product.text!)
//        ad?.expired.append(expired.text!)
//        ad?.barcode.append(barcode.text!)
//        
//        _ = self.navigationController?.popViewController(animated: true)
//    }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        // Do any additional setup after loading the view.
//    }
//
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
//    
//
//    /*
//    // MARK: - Navigation
//
//    // In a storyboard-based application, you will often want to do a little preparation before navigation
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        // Get the new view controller using segue.destinationViewController.
//        // Pass the selected object to the new view controller.
//    }
//    */
//
//}
