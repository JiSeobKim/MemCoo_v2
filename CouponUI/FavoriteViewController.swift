//
//  FirstViewController.swift
//  CouponUI
//
//  Created by mino on 2016. 12. 2..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit
import CoreData

class FavoriteViewController: UITableViewController, NSFetchedResultsControllerDelegate {

    var membershipController: NSFetchedResultsController<Membership>!
    var couponController: NSFetchedResultsController<Coupon>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        let coupons = couponFetch()
        let memberships = membershipFetch()
        
        objectsArray = [favoriteObjects(sectionName: "멤버십", sectionObjects: memberships), favoriteObjects(sectionName: "쿠폰", sectionObjects: coupons)]
        
        self.tableView.reloadData()
    }
    
    // MARK: - Data Source Model
    struct favoriteObjects {
        var sectionName: String!
        var sectionObjects: [Any]!
    }
    var objectsArray = [favoriteObjects]()
    
    // MARK: - TableView overriding
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
   
    //cell 숫자 정의
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return objectsArray[section].sectionObjects.count
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {

        return objectsArray.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return objectsArray[section].sectionName
    }
    
    func configureCell(cell: FavoriteCell, indexPath: NSIndexPath) {

         let item = objectsArray[indexPath.section].sectionObjects[indexPath.row]
            
         cell.configureCell(item: item)
        
    }
    

    
    // MARK: - coreData 부분
    
    
    //membership 패치해오는 펑션
    func membershipFetch() -> [Membership] {
        var membership: [Membership] = []
        let fetchRequest: NSFetchRequest<Membership> = Membership.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let favoriteSort = NSSortDescriptor(key: "favorite", ascending: false)
        
        let favorite = "favorite"
        
        let isPrediccate = NSPredicate(format: "%K == YES", favorite)
        fetchRequest.sortDescriptors = [dateSort,favoriteSort]
        fetchRequest.predicate = isPrediccate
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        //save시 tableview update를 위한 델리게이트 전달
        controller.delegate = self
        self.membershipController = controller
        
        do{
            membership = try ad.persistentContainer.viewContext.fetch(fetchRequest)
            return membership
        } catch {
            print("\(error)")
        }
        return membership
    }
    
    //coupon 패치해오는 펑션
    func couponFetch() -> [Coupon] {
        var coupon: [Coupon] = []
        let fetchRequest: NSFetchRequest<Coupon> = Coupon.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let favoriteSort = NSSortDescriptor(key: "favorite", ascending: false)
        
        let favorite = "favorite"
        
        let isPrediccate = NSPredicate(format: "%K == YES", favorite)
        fetchRequest.sortDescriptors = [dateSort,favoriteSort]
        fetchRequest.predicate = isPrediccate
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        
        //save시 tableview update를 위한 델리게이트 전달
        controller.delegate = self
        self.couponController = controller
        
        do{
            coupon = try ad.persistentContainer.viewContext.fetch(fetchRequest)
            return coupon
        } catch {
            print("\(error)")
        }
        return coupon
    }
    //컨트롤러가 바뀔때마다 테이블뷰 업데이트
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        switch type {
        case .insert:
            tableView.insertSections(IndexSet(integer: sectionIndex), with: .fade)
        case .delete:
            tableView.deleteSections(IndexSet(integer: sectionIndex), with: .fade)
        default:
            break;
        }
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
                let cell = tableView.cellForRow(at: indexPath) as! FavoriteCell
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

}

