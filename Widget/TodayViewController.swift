//
//  TodayViewController.swift
//  Widget
//
//  Created by 김지섭 on 2017. 1. 8..
//  Copyright © 2017년 mino. All rights reserved.
//

import UIKit
import NotificationCenter

class TodayViewController: UIViewController, NCWidgetProviding {
    
    
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    
    @IBAction func buttonAction1(_ sender: Any) {
        imageView.image = UIImage(named: "telecommunication2")
    }
    @IBAction func buttonAction2(_ sender: Any) {
        imageView.image = UIImage(named: "telecommunication3")
    }
    @IBAction func buttonAction3(_ sender: Any) {
        imageView.image = UIImage(named: "telecommunication4")
    }
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view from its nib.
        
        self.extensionContext?.widgetLargestAvailableDisplayMode = NCWidgetDisplayMode.expanded
        
        imageView.image = UIImage(named: "defaultBarcode")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func widgetPerformUpdate(completionHandler: (@escaping (NCUpdateResult) -> Void)) {
        // Perform any setup necessary in order to update the view.
        
        // If an error is encountered, use NCUpdateResult.Failed
        // If there's no update required, use NCUpdateResult.NoData
        // If there's an update, use NCUpdateResult.NewData
        
        completionHandler(NCUpdateResult.newData)
    }
    
    func widgetActiveDisplayModeDidChange(_ activeDisplayMode: NCWidgetDisplayMode, withMaximumSize maxSize: CGSize) {
        if (activeDisplayMode == NCWidgetDisplayMode.compact) {
            self.preferredContentSize = maxSize
        }
        else {
            self.preferredContentSize = CGSize(width: maxSize.width, height: 200)
        }
    }
    
}
