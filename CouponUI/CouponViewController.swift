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
    @IBOutlet weak var viewSegment: UIView!
    
    var originalImage: UIImage!
    let imagePicker = UIImagePickerController()
    
    var controller: NSFetchedResultsController<Coupon>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        imagePicker.delegate = self
        attemptFetch()
        
        
        self.tableView.tableHeaderView = viewSegment
        
        //long press gesture를 이용한 즐겨찾기 핸들링.
        let longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(self.longPress))
        self.view.addGestureRecognizer(longPressGestureRecognizer)
        
        
        self.parent?.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //노티피케이션.
        NotificationCenter.default.addObserver(self, selector: #selector(self.catchIt), name: NSNotification.Name(rawValue: "myNotif"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let prefs: UserDefaults = UserDefaults.standard
        if prefs.value(forKey: "startUpNotif") != nil {
            let userInfo: [AnyHashable: Any] = ["inactive": "inactive"]
            NotificationCenter.default.post(name: Notification.Name(rawValue: "myNotif"), object: nil, userInfo: userInfo as [AnyHashable: Any])
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        NotificationCenter.default.removeObserver(self)
    }
    
    //+버튼 눌렀을때의 액션
    @IBAction func add(_ sender: Any) {
        let alert = UIAlertController(title: "쿠폰 추가", message: "쿠폰을 추가할 방식을 선택해주세요.", preferredStyle: .actionSheet)
        
//컬러가 바뀌어서 주석처리했습니다.
//        alert.view.tintColor = UIColor.black
        
        let clipboard = UIAlertAction(title: "클립보드 내용 자동 추가", style: .default) {
            (_) in
            //액션시트의 첫 번째 버튼이 눌렸음을 다음 뷰에 전달하기 위해 앱델리게이트의 selectActionSheet 변수에 1을 저장.
            ad.clipboardActionSheet = 1
            
            //다음 뷰컨트롤러로 push.
            if let addVC = self.storyboard?.instantiateViewController(withIdentifier: "AddEdit") {
                self.navigationController?.pushViewController(addVC, animated: true)
            }
        }
        
        let ocr = UIAlertAction(title: "쿠폰 이미지에서 텍스트 추출", style: .default) {
            (_) in
            ad.clipboardActionSheet = 2
            
            //이미지 선택 뷰.
            self.imagePicker.sourceType = UIImagePickerController.SourceType.savedPhotosAlbum    //.photoLibrary
            //imagePicker.mediaTypes = [kUTTypeImage as String]
            self.imagePicker.allowsEditing = false
            self.present(self.imagePicker, animated: true, completion: nil)
        }
        
        let custom = UIAlertAction(title: "사용자 직접 입력", style: .default) {
            (_) in
            ad.clipboardActionSheet = 3
            
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
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
// Local variable inserted by Swift 4.2 migrator.
let info = convertFromUIImagePickerControllerInfoKeyDictionary(info)

        if let image = info[convertFromUIImagePickerControllerInfoKey(UIImagePickerController.InfoKey.originalImage)] as? UIImage {
            self.originalImage = image
            picker.dismiss(animated: true, completion: nil)
            
            //뷰 전환.
            if self.originalImage != nil {
                if let addVC = self.storyboard?.instantiateViewController(withIdentifier: "AddEdit") as? CouponAddViewController {
                    addVC.originalImage = self.originalImage
                    self.navigationController?.pushViewController(addVC, animated: true)
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    
    
    //long press gesture를 이용한 즐겨찾기 핸들링.
    @objc func longPress(_ longPressGestureRecognizer: UILongPressGestureRecognizer) {
        if longPressGestureRecognizer.state == UIGestureRecognizer.State.began {
            let touchPoint = longPressGestureRecognizer.location(in: self.tableView)
            
            if let indexPath = tableView.indexPathForRow(at: touchPoint) {
                if var objs = controller.fetchedObjects, objs.count > 0 {
                    let item = objs[indexPath.row]
                    
                    if item.isFavorite == false {
                        let alert = UIAlertController(title: "즐겨찾기 추가", message: "\"\(item.title!)\" 쿠폰을\n즐겨찾기에 추가하시겠습니까?", preferredStyle: .alert)
                        //테마 색 바뀌어서 우선 주석 처리하겠습니다
//                        alert.view.tintColor = UIColor.black
                        
                        let add = UIAlertAction(title: "추가", style: .default) {
                            (_) in
                            let favoriteContext = Favorite(context: context)
                            item.isFavorite = true
                            
                            favoriteContext.isCoupon = true
                            favoriteContext.isMembership = false
                            favoriteContext.index = 0
                            item.toFavorite = favoriteContext
                            ad.saveContext()
                        }
                        
                        let cancel = UIAlertAction(title: "취소", style: .cancel)
                        alert.addAction(add)
                        alert.addAction(cancel)
                        self.present(alert, animated: true)
                    }
                    else {
                        let alert = UIAlertController(title: "즐겨찾기 제거", message: "\"\(item.title!)\" 쿠폰을\n즐겨찾기에서 제거하시겠습니까?", preferredStyle: .alert)
                        //위와 동일
                        //alert.view.tintColor = UIColor.black
                        
                        let add = UIAlertAction(title: "제거", style: .default) {
                            (_) in
                            item.isFavorite = false
                            context.delete(item.toFavorite!)
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
        return 92
    }
    
    //swipe 시 edit 기능 가능하게 하는 메소드.
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //swipe 시 delete 버튼이 작동하는 메소드.
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCell.EditingStyle.delete {
            if var objs = controller.fetchedObjects, objs.count > 0{
                let item = objs[indexPath.row]
                
                let alert = UIAlertController(title: "쿠폰 삭제", message: "\"\(item.title!)\" 쿠폰을\n삭제하시겠습니까?", preferredStyle: .alert)
                alert.view.tintColor = UIColor.black
                
                let delete = UIAlertAction(title: "삭제", style: .destructive) {
                    (_) in
                    if item.isFavorite == true {
                        context.delete(item.toFavorite!)
                    }
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
        
        if segment.selectedSegmentIndex == 0 {
            let isPredicate = NSPredicate(format: "%K == NO", "isUsed")
            fetchRequest.predicate = isPredicate
        }else if segment.selectedSegmentIndex == 1 {
            let isPredicate = NSPredicate(format: "%K == YES", "isUsed")
            fetchRequest.predicate = isPredicate
        }else if segment.selectedSegmentIndex == 2 {
    
        }
        
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
    @IBAction func segmentChanged(_ sender: UISegmentedControl) {
        attemptFetch()
        tableView.reloadData()
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

extension UIViewController {
    //노티피케이션.
    @objc func catchIt(_ userInfo: Notification) {
        if userInfo.userInfo?["userInfo"] == nil {
            if let detailVC = self.storyboard?.instantiateViewController(withIdentifier: "SimpleViewController") {
                self.navigationController?.pushViewController(detailVC, animated: true)
            }
        }
    }
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKeyDictionary(_ input: [UIImagePickerController.InfoKey: Any]) -> [String: Any] {
	return Dictionary(uniqueKeysWithValues: input.map {key, value in (key.rawValue, value)})
}

// Helper function inserted by Swift 4.2 migrator.
fileprivate func convertFromUIImagePickerControllerInfoKey(_ input: UIImagePickerController.InfoKey) -> String {
	return input.rawValue
}
