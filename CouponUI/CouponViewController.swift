//
//  CouponViewController.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 05/12/2016.
//  Copyright © 2016 mino. All rights reserved.
//

import UIKit
import CoreData
import TesseractOCR

class CouponViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate, G8TesseractDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    //밝기 조절하는 변수.
    
    
    //detail에서 넘어온 coupon 객체를 받기하기 위한 coupon 객체
    var couponToDelete: Coupon?
    
    //+버튼 눌렀을때의 액션
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "쿠폰 추가", message: "쿠폰을 추가할 방식을 선택해주세요.", preferredStyle: .actionSheet)
        
        let clipboard = UIAlertAction(title: "클립보드 내용 자동 추가", style: .default) {
            (_) in
            //액션시트의 첫 번째 버튼이 눌렸음을 다음 뷰에 전달하기 위해 앱델리게이트의 selectActionSheet 변수에 1을 저장.
            ad.selectActionSheet = 1
            
            //다음 뷰컨트롤러로 push.
            if let addVC = self.storyboard?.instantiateViewController(withIdentifier: "AddEdit") {
                self.navigationController?.pushViewController(addVC, animated: true)
            }
        }
        
        let ocr = UIAlertAction(title: "사진에서 바코드만 읽어오기", style: .default) {
            (_) in
            //파싱 퍼센트 표시 알림창.
//            func progressImageRecognition(for tesseract: G8Tesseract!) {
//                let progress = UIAlertController(title: "알림", message: "Recognition Progress: \(tesseract.progress)%", preferredStyle: UIAlertControllerStyle.alert)
//                self.present(progress, animated: true)
//                
//                if tesseract.progress >= 90 {
//                    self.dismiss(animated: true)
//                }
//            }
            
            ad.selectActionSheet = 2
            
            if let addVC = self.storyboard?.instantiateViewController(withIdentifier: "AddEdit") {
                self.navigationController?.pushViewController(addVC, animated: true)
            }
        }
        
        let custom = UIAlertAction(title: "사용자 직접 입력", style: .default) {
            (_) in
            ad.selectActionSheet = 3
            
            if let addVC = self.storyboard?.instantiateViewController(withIdentifier: "AddEdit") {
                self.navigationController?.pushViewController(addVC, animated: true)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(clipboard)
        alert.addAction(ocr)
        alert.addAction(custom)
        alert.addAction(cancel)
        
        //add 버튼이 눌렸음을 다음 뷰에 전달하기 위해 isAddButton 변수에 true를 저장.
        ad.isAddButton = true
        self.present(alert, animated: true)
    }
    
    var controller: NSFetchedResultsController<Coupon>!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        attemptFetch()
    }
    
 

    
    //tableView를 위한 function
    //cell 재사용 정의
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CouponCell", for: indexPath) as! CouponCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        return cell
    }
    
    func configureCell(cell: CouponCell, indexPath: NSIndexPath) {
        //update cell
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }

    //cell 숫자 정의
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            return sectionInfo.numberOfObjects
        }
        return 0
    }

    //선택된 cell의 처리 정의
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects, objs.count > 0 {
            let item = objs[indexPath.row]
            performSegue(withIdentifier: "CouponDetailsVC", sender: item)
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "CouponDetailsVC" {
            if let destination = segue.destination as? CouponDetailViewController {
                if let coupon = sender as? Coupon {
                    destination.couponToDetail = coupon
                    ap.bright = UIScreen.main.brightness
                    destination.bright = UIScreen.main.brightness
                }
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = controller.sections {
            return sections.count
        }
        return 0
    }
    
    //cell의 높이 정의
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    //swipe 시 edit 기능 가능하게 하는 메소드.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //swipe 시 delete 버튼 나타나게 하는 메소드.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
//            if couponToDelete != nil {
//                context.delete(couponToDelete!)
//                ad.saveContext()
//                tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
//            }
            if var objs = controller.fetchedObjects, objs.count > 0{
                let item = objs[indexPath.row]
                context.delete(item)
                ad.saveContext()
            }
        }
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
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
        case .delete:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
            }
            break
        case .update:
            if let indexPath = indexPath {
                let cell = tableView.cellForRow(at: indexPath) as! CouponCell
                // update the cell data.
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case .move:
            if let indexPath = indexPath {
                tableView.deleteRows(at: [indexPath], with: .fade)
                
            }
            if let indexPath = newIndexPath {
                tableView.insertRows(at: [indexPath], with: .fade)
            }
            break
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
