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

class CouponViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSFetchedResultsControllerDelegate, G8TesseractDelegate {
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var segment: UISegmentedControl!
    
    var originalImage: UIImage!
    let imagePicker = UIImagePickerController()
    
    //+버튼 눌렀을때의 액션
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "쿠폰 추가", message: "쿠폰을 추가할 방식을 선택해주세요.", preferredStyle: .actionSheet)
        
        let clipboard = UIAlertAction(title: "클립보드 내용 자동 추가", style: .default) {
            (_) in
            //액션시트의 첫 번째 버튼이 눌렸음을 다음 뷰에 전달하기 위해 앱델리게이트의 selectActionSheet 변수에 1을 저장.
            ad.isClipboardActionSheet = true
            
            //다음 뷰컨트롤러로 push.
            if let addVC = self.storyboard?.instantiateViewController(withIdentifier: "AddEdit") {
                self.navigationController?.pushViewController(addVC, animated: true)
            }
        }
        
        let ocr = UIAlertAction(title: "사진에서 바코드만 읽어오기", style: .default) {
            (_) in            
            ad.isClipboardActionSheet = false
            
            //이미지 선택 뷰.
            self.imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
            //imagePicker.mediaTypes = [kUTTypeImage as String]
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true, completion: nil)
            
            //뷰 전환.
            if let addVC = self.storyboard?.instantiateViewController(withIdentifier: "AddEdit") as? CouponAddViewController {
                addVC.originalImage = self.originalImage
                self.navigationController?.pushViewController(addVC, animated: true)
            }
        }
        
        let custom = UIAlertAction(title: "사용자 직접 입력", style: .default) {
            (_) in
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
    
    //사진 앱 접근을 위한 메소드.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String: Any]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            self.originalImage = image
        }
        self.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
    }
    
    var controller: NSFetchedResultsController<Coupon>!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        imagePicker.delegate = self
        attemptFetch()
        
        //long press gesture를 이용한 즐겨찾기 핸들링.
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        self.view.addGestureRecognizer(longPressGestureRecognizer)
    }
    
    //long press gesture를 이용한 즐겨찾기 핸들링.
    func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizerState.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.tableView)
            
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                if var objs = controller.fetchedObjects, objs.count > 0 {
                    let item = objs[indexPath.row]
                    
                    if item.favorite == false {
                        let alert = UIAlertController(title: "즐겨찾기 추가", message: "\"\(item.title!)\" 쿠폰을 \n즐겨찾기에 추가하시겠습니까?", preferredStyle: .alert)
                        let add = UIAlertAction(title: "추가", style: .default) {
                            (_) in
                            item.favorite = true
                            ad.saveContext()
                        }
                        
                        let cancel = UIAlertAction(title: "취소", style: .cancel)
                        alert.addAction(add)
                        alert.addAction(cancel)
                        self.present(alert, animated: true)
                    }
                    else {
                        let alert = UIAlertController(title: "즐겨찾기 제거", message: "\"\(item.title!)\" 쿠폰을 \n즐겨찾기에서 제거하시겠습니까?", preferredStyle: .alert)
                        let add = UIAlertAction(title: "제거", style: .default) {
                            (_) in
                            item.favorite = false
                            ad.saveContext()
                        }
                        
                        let cancel = UIAlertAction(title: "취소", style: .cancel)
                        alert.addAction(add)
                        alert.addAction(cancel)
                        self.present(alert, animated: true)
                    }
                }
            }
        }
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
        //셀 선택 후 뒤로 돌아왔을 때 선택 취소.
        tableView.deselectRow(at: indexPath, animated: true)
        
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
                    ad.bright = UIScreen.main.brightness
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
    
    //swipe 시 delete 버튼이 작동하는 메소드.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            if var objs = controller.fetchedObjects, objs.count > 0{
                let alert = UIAlertController(title: "삭제하시겠습니까?", message: "한 번 삭제한 쿠폰은 복구할 수 없습니다!", preferredStyle: .alert)
                let delete = UIAlertAction(title: "삭제", style: .destructive) {
                    (_) in
                    let item = objs[indexPath.row]
                    context.delete(item)
                    ad.saveContext()
                }
                let cancel = UIAlertAction(title: "취소", style: .cancel)
                alert.addAction(delete)
                alert.addAction(cancel)
                self.present(alert, animated: true)
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
