//
//  TabBarVC.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 12/03/2017.
//  Copyright © 2017 mino. All rights reserved.
//

import UIKit

class TabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
         self.tabBar.unselectedItemTintColor = UIColor(red: 84/255, green: 84/255, blue: 84/255, alpha: 0.78)
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
