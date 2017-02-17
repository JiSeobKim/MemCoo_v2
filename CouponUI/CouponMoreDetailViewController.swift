//
//  CouponMoreDetailViewController.swift
//  MemebershipCoupon
//
//  Created by mino on 2017. 2. 18..
//  Copyright © 2017년 mino. All rights reserved.
//

import UIKit

class CouponMoreDetailViewController: UIViewController {
    @IBOutlet weak var originalTextView: UITextView!
    @IBOutlet weak var originalImageView: UIImageView!
    
    var originalText: String?
    var originalImage: UIImage?

    @IBAction func close(_ sender: Any) {
        self.presentingViewController?.dismiss(animated: true)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if originalText == nil {
            originalTextView.isHidden = true
        }
        if let text = originalText {
            originalTextView.text = text
        }
        
        if originalImage == nil {
            originalImageView.isHidden = true
        }
        if let image = originalImage {
            originalImageView.image = image
        }
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
