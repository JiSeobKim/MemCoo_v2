////
////  DetailCouponViewController.swift
////  CouponUI
////
////  Created by mino on 2016. 12. 3..
////  Copyright © 2016년 mino. All rights reserved.
////
//
//import UIKit
//
//class DetailCouponViewController: UIViewController {
//    @IBOutlet weak var product: UILabel!
//    @IBOutlet weak var expired: UILabel!
//    @IBOutlet weak var barcode: UILabel!
//    @IBOutlet weak var barcodeImage: UIImageView!
//    
//    let ad = UIApplication.shared.delegate as? AppDelegate
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        
//        self.navigationItem.title = ad?.product[(ad?.row)!]
//        product.text = ad?.product[(ad?.row)!]
//        expired.text = ad?.expired[(ad?.row)!]
//        barcode.text = ad?.barcode[(ad?.row)!]
//        
//        let generateBarcode = GenerateBarcode()
//        barcodeImage.image = generateBarcode.fromString(string: barcode.text!)
//        
//    }
//    
//    @IBAction func editButton(_ sender: Any) {
//        if let editVC = self.storyboard?.instantiateViewController(withIdentifier: "AddEdit") {
//            self.navigationController?.pushViewController(editVC, animated: true)
//        }
//    }
//    
//    @IBAction func usedButton(_ sender: Any) {
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
