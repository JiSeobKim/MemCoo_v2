//
//  SettingsTableViewController.swift
//  MemebershipCoupon
//
//  Created by mino on 2017. 1. 7..
//  Copyright © 2017년 mino. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {
    
   
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
