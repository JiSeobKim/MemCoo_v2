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
    var favoriteController: NSFetchedResultsController<Favorite>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
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

        if objectsArray[0].sectionObjects.count == 0, objectsArray[1].sectionObjects.count == 0 {
            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
            noDataLabel.text = "등록된 즐겨찾기가 없습니다. \r\n 즐겨찾는 아이템을 등록해 주세요."
            noDataLabel.textAlignment = .center
            noDataLabel.numberOfLines = 0
            noDataLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
            tableView.backgroundView = noDataLabel
        } else {
            tableView.backgroundView = nil
        }
        
        return objectsArray.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {

        return objectsArray[section].sectionName
    }
    
    //tableview re-oderring
    @IBAction func startEditing(_ sender: Any) {
        
        tableView.setEditing(true, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        return UITableViewCellEditingStyle.none
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        if sourceIndexPath.section == 0 {
            var memberships = membershipFetch()
            let membershipToMove = memberships[sourceIndexPath.row]
            memberships.remove(at: sourceIndexPath.row)
            memberships.insert(membershipToMove, at: destinationIndexPath.row)
            for index in 0..<memberships.count {
                //index 0은 최초 즐겨찾기가 생성되는 아이템을 위해 비워둠
                memberships[index].index = Int32(index) + 1
            }
        } else {
            var coupons = couponFetch()
            let couponToMove = coupons[sourceIndexPath.row]
            coupons.remove(at: sourceIndexPath.row)
            coupons.insert(couponToMove, at: destinationIndexPath.row)
            for index in 0..<coupons.count {
                //index 0은 최초 즐겨찾기가 생성되는 아이템을 위해 비워둠
                coupons[index].index = Int32(index) + 1
            }
        }
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func configureCell(cell: FavoriteCell, indexPath: NSIndexPath) {

         let item = objectsArray[indexPath.section].sectionObjects[indexPath.row]
            
         cell.configureCell(item: item)
        
    }
    
    //section간에만 이동할 수 있도록 제한
    override func tableView(_ tableView: UITableView, targetIndexPathForMoveFromRowAt sourceIndexPath: IndexPath, toProposedIndexPath proposedDestinationIndexPath: IndexPath) -> IndexPath {
        if sourceIndexPath.section != proposedDestinationIndexPath.section {
            var row = 0
            if sourceIndexPath.section < proposedDestinationIndexPath.section {
                row = self.tableView(tableView, numberOfRowsInSection: sourceIndexPath.section) - 1
            }
            return IndexPath(row: row, section: sourceIndexPath.section)
        }
        return proposedDestinationIndexPath
    }
    
    // MARK: - coreData 부분
    
    
    //membership 패치해오는 펑션
    func membershipFetch() -> [Favorite] {
//        var membership: [Membership] = []
//        let fetchRequest: NSFetchRequest<Membership> = Membership.fetchRequest()
//        let dateSort = NSSortDescriptor(key: "created", ascending: false)
//        let favoriteSort = NSSortDescriptor(key: "favorite", ascending: false)
//        
//        let favorite = "favorite"
//        
//        let isPrediccate = NSPredicate(format: "%K == YES", favorite)
//        fetchRequest.sortDescriptors = [dateSort,favoriteSort]
//        fetchRequest.predicate = isPrediccate
//        
//        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//        
//        //save시 tableview update를 위한 델리게이트 전달
//        controller.delegate = self
//        self.membershipController = controller
//        
//        do{
//            membership = try ad.persistentContainer.viewContext.fetch(fetchRequest)
//            return membership
//        } catch {
//            print("\(error)")
//        }
//        return membership
        
        var favorite: [Favorite] = []
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        //let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let favoriteSort = NSSortDescriptor(key: "index", ascending: true)
        
        let isPrediccate = NSPredicate(format: "%K == YES", "isMembership")
        fetchRequest.sortDescriptors = [favoriteSort]
        fetchRequest.predicate = isPrediccate
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.favoriteController = controller
        
        do{
            favorite = try ad.persistentContainer.viewContext.fetch(fetchRequest)
            for index in 0..<favorite.count {
                favorite[index].index = Int32(index) + 1
            }
            ad.saveContext()
            return favorite
        } catch {
            print("\(error)")
        }
        return favorite
    }
    
    //coupon 패치해오는 펑션
    func couponFetch() -> [Favorite] {
//        var coupon: [Coupon] = []
//        let fetchRequest: NSFetchRequest<Coupon> = Coupon.fetchRequest()
//        let dateSort = NSSortDescriptor(key: "created", ascending: false)
//        let favoriteSort = NSSortDescriptor(key: "favorite", ascending: false)
//        
//        let favorite = "favorite"
//        
//        let isPrediccate = NSPredicate(format: "%K == YES", favorite)
//        fetchRequest.sortDescriptors = [dateSort,favoriteSort]
//        fetchRequest.predicate = isPrediccate
//        
//        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
//        
//        //save시 tableview update를 위한 델리게이트 전달
//        controller.delegate = self
//        self.couponController = controller
//        
//        do{
//            coupon = try ad.persistentContainer.viewContext.fetch(fetchRequest)
//            return coupon
//        } catch {
//            print("\(error)")
//        }
//        return coupon
        
        var favorite: [Favorite] = []
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
//        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let favoriteSort = NSSortDescriptor(key: "index", ascending: true)
        
        let isPrediccate = NSPredicate(format: "%K == YES", "isCoupon")
        fetchRequest.sortDescriptors = [favoriteSort]
        fetchRequest.predicate = isPrediccate
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: nil, cacheName: nil)
        controller.delegate = self
        self.favoriteController = controller

        do{
            favorite = try ad.persistentContainer.viewContext.fetch(fetchRequest)
            
            for index in 0..<favorite.count {
                favorite[index].index = Int32(index) + 1
            }
            ad.saveContext()
            return favorite
        } catch {
            print("\(error)")
        }
        return favorite
        
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

