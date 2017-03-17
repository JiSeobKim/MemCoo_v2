//
//  FirstViewController.swift
//  UISample
//
//  Created by mino on 2016. 11. 11..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit
import CoreData

class MembershipCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate, UIGestureRecognizerDelegate{

    
//
//model
//
    @IBOutlet weak var collectionView: UICollectionView!
    var controller: NSFetchedResultsController<Membership>!
    
  
    
//
//viewLoad
//
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        attemptFetch()
        
        //롱프레스
        let lpgr : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MembershipCollectionVC.handleLongPress(_:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delegate = self
        lpgr.delaysTouchesBegan = true
        self.collectionView?.addGestureRecognizer(lpgr)
        
        
        //Cell Size
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        let width = UIScreen.main.bounds.width
        layout.sectionInset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        layout.itemSize = CGSize(width: width / 3.4, height: width / 3)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        collectionView!.collectionViewLayout = layout


        
        
        
    }

    override func viewWillAppear(_ animated: Bool) {
                // 뷰2->뷰1는 viewDidLoad로 못함
        
       
        attemptFetch()
        self.collectionView.reloadData()

        
    }
    
    func handleLongPress(_ gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizerState.ended {
            return
        }
        
        let p = gestureReconizer.location(in: collectionView)
        let indexPath = collectionView.indexPathForItem(at: p)
        
        if let index = indexPath {
            _ = collectionView.cellForItem(at: index)
            // do stuff with your cell, for example print the indexPath
            print(index.row)
            
            if let objs = controller.fetchedObjects, objs.count > 0 {
                let item = objs[(indexPath?.item)!]
                
        
                if item.favorite == true {
                    item.favorite = false
                } else {
                    item.favorite = true
                }
                ad.saveContext()
                collectionView.reloadData()
            
            }

        } else {
            print("Could not find index path")
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        return CGSize(width: (width - 10)/100, height: (width - 10)/100) // width & height are the same to make a square cell
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
                    
                    // 밝기 값 저장 
                    destination.bright = UIScreen.main.brightness
                    ad.bright = UIScreen.main.brightness
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
    
}

