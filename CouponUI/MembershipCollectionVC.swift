//
//  FirstViewController.swift
//  UISample
//
//  Created by mino on 2016. 11. 11..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit
import CoreData

class MembershipCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate {

 
    
    @IBOutlet weak var collectionView: UICollectionView!
    var controller: NSFetchedResultsController<Membership>!
    //CollectionView 이름 선언
    //45,71,88 라인에서 사용
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        attemptFetch()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    
    override func viewWillAppear(_ animated: Bool) {
                // 뷰2->뷰1는 viewDidLoad로 못함
        
       
        self.collectionView.reloadData()
        //컬렉션뷰 릴로드
        ad.showNow = nil
       
        
    }
    
    
    
   
    
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //컬렉션 뷰 셀 갯수 생성
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            
            return sectionInfo.numberOfObjects
        }
        return 0

        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewcell", for: indexPath) as! MembershipCollectionVCell
        // 설정할 cell 선택(빨간 "viewcell"은 어트리뷰트인스펙터의 identifier)
        
        
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        //로고의 이미지/ 텍스트 값 대입
        
        
  
        return cell
        
    }
    
    func configureCell(cell: MembershipCollectionVCell, indexPath: NSIndexPath) {
        
        //update cell
        
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects, objs.count > 0 {
            let item = objs[indexPath.item]
            performSegue(withIdentifier: "showCollection", sender: item)
        }
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCollection" {
            if let destination = segue.destination as? ShowMembershipVC {
                if let membership = sender as? Membership {
                    destination.cellData = membership
                }
            }
        }
    }
    
//    @IBAction func unwindMembershipMain(sender: UIStoryboardSegue){
//        
//    }
    
    //coreData 부분
    
    //패치해오는 펑션
    
    func attemptFetch() {
        
        let fetchRequest: NSFetchRequest<Membership> = Membership.fetchRequest()
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
//    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        
//        collectionView.up
//        
//    }
//    
//    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
//        
//        collectionView.endUpdates()
//        
//    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
        
        switch (type) {
        case .insert:
            if let indexPath = newIndexPath {
                collectionView.insertItems(at: [indexPath])
            }
            break
        case .delete:
            if let indexPath = indexPath {
                collectionView.deleteItems(at: [indexPath])
            }
            break
        case .update:
            if let indexPath = indexPath {
                let cell = collectionView.cellForItem(at: indexPath) as! MembershipCollectionVCell
                // update the cell data.
                
                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
            }
            break
        case .move:
            if let indexPath = indexPath {
                collectionView.deleteItems(at: [indexPath])
                
            }
            if let indexPath = newIndexPath {
                collectionView.insertItems(at: [indexPath])
                
            }
            break
        }
        
    }
    
    func generateTestData() {
        let item = Coupon(context: context)
        
        item.title = "문화상품권"
        item.expireDate = Date() as NSDate
        
        let item2 = Coupon(context: context)
        
        item2.title = "독서상품권"
        item2.expireDate = Date() as NSDate
        
        
        ad.saveContext()
    }


    

}

