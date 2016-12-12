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

    
//
//model
//
    @IBOutlet weak var collectionView: UICollectionView!
    var controller: NSFetchedResultsController<Membership>!
    //CollectionView 이름 선언
    //45,71,88 라인에서 사용
    
//
//viewLoad
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        attemptFetch()
    }

    override func viewWillAppear(_ animated: Bool) {
                // 뷰2->뷰1는 viewDidLoad로 못함
        
       
        attemptFetch()
        self.collectionView.reloadData()
        //컬렉션뷰 릴로드
        ad.showNow = nil
       
        
    }
    
    
    
//
//controller
//
    
//컬렉션 뷰 셀 갯수 생성
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
       
        if let sections = controller.sections {
            let sectionInfo = sections[section]
            
            return sectionInfo.numberOfObjects
        }
        return 0

        
    }
    
//셀 재사용을 위한 정의
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewcell", for: indexPath) as! MembershipCollectionVCell
        // 설정할 cell 선택(빨간 "viewcell"은 어트리뷰트인스펙터의 identifier)
        
        
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        //로고의 이미지/ 텍스트 값 대입
        
        
  
        return cell
        
    }
    
//셀 생성 정의
    func configureCell(cell: MembershipCollectionVCell, indexPath: NSIndexPath) {
        
        //update cell
        
        let item = controller.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
    }
    
//선택된 셀을 사용하기위한 정의
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let objs = controller.fetchedObjects, objs.count > 0 {
            let item = objs[indexPath.item]
            performSegue(withIdentifier: "showCollection", sender: item)
        }
    }

//화면전환시 데이터 넘기기 위한 준비
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCollection" {
            if let destination = segue.destination as? ShowMembershipVC {
                if let membership = sender as? Membership {
                    destination.cellData = membership
                }
            }
        }
    }
    
    
//
//coreData 부분
//
    
    
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
    
//콘트롤러 정의
//    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange anObject: Any, at indexPath: IndexPath?, for type: NSFetchedResultsChangeType, newIndexPath: IndexPath?) {
//        
//        switch (type) {
//        case .insert:
//            if let indexPath = newIndexPath {
//                collectionView.insertItems(at: [indexPath])
//            }
//            break
//        case .delete:
//            if let indexPath = indexPath {
//                collectionView.deleteItems(at: [indexPath])
//            }
//            break
//        case .update:
//            if let indexPath = indexPath {
//                let cell = collectionView.cellForItem(at: indexPath) as! MembershipCollectionVCell
//                // update the cell data.
//                
//                configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
//            }
//            break
//        case .move:
//            if let indexPath = indexPath {
//                collectionView.deleteItems(at: [indexPath])
//                
//            }
//            if let indexPath = newIndexPath {
//                collectionView.insertItems(at: [indexPath])
//                
//            }
//            break
//        }
//    }
}

