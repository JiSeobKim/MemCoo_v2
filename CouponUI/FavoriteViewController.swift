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
    
    //    var membershipController: NSFetchedResultsController<Membership>!
    //    var couponController: NSFetchedResultsController<Coupon>!
    var favoriteController: NSFetchedResultsController<Favorite>!
    var isMovingItem : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        let coupons = couponFetch()
        //        let memberships = membershipFetch()
        //
        //        objectsArray = [favoriteObjects(sectionName: "멤버십", sectionObjects: memberships), favoriteObjects(sectionName: "쿠폰", sectionObjects: coupons)]
        
        attemptFetch()
        
        self.tableView.reloadData()
    }
    
    // MARK: - Data Source Model
    //    struct favoriteObjects {
    //        var sectionName: String!
    //        var sectionObjects: [Any]!
    //    }
    //    var objectsArray = [favoriteObjects]()
    
    // MARK: - TableView overriding
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    
    //cell 숫자 정의
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //        return objectsArray[section].sectionObjects.count
        
        if let sections = favoriteController.sections {
            let sectionInfo = sections[section]
            
            return sectionInfo.numberOfObjects
        }
        return 0
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        
        //        if objectsArray[0].sectionObjects.count == 0, objectsArray[1].sectionObjects.count == 0 {
        //            let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        //            noDataLabel.text = "등록된 즐겨찾기가 없습니다. \r\n 즐겨찾는 아이템을 등록해 주세요."
        //            noDataLabel.textAlignment = .center
        //            noDataLabel.font = UIFont(name: noDataLabel.font.fontName, size: 12)
        //            noDataLabel.numberOfLines = 0
        //            noDataLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        //            tableView.backgroundView = noDataLabel
        //        } else {
        //            tableView.backgroundView = nil
        //        }
        //
        //        return objectsArray.count
        if let sections = favoriteController.sections {
            return sections.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        if let sections = favoriteController.sections {
            let sectionInfo = sections[section].name
            if sectionInfo == "0" {
                return "멤버십"
            } else if sectionInfo == "1" {
                return "쿠폰"
            }
        }
        return "섹션"
    }
    
    //tableview re-oderring
    
    @IBAction func startEditing(_ sender: Any) {
        
        tableView.setEditing(true, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return .delete
        }
        
        return .none
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            //                if indexPath.section == 0 {
            //                    let memberships = membershipFetch()
            //                    let item = memberships[indexPath.row]
            //
            //                    item.toMembership?.favorite = false
            //
            //                    context.delete(item)
            //                    self.tableView.reloadData()
            //
            //                }
            //                if indexPath.section == 1 {
            //                    let coupons = couponFetch()
            //                    let item = coupons[indexPath.row]
            //
            //                    item.toCoupon?.favorite = false
            //
            //                    context.delete(item)
            //                    self.tableView.reloadData()
            //                }
            
            ad.saveContext()
        }
    }
    
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        isMovingItem = true
//        if let sections = favoriteController.sections {
//            let sectionInfo = sections[sourceIndexPath.section].name
//            
//            if sectionInfo == "0" {
//                if var objs = favoriteController.fetchedObjects
//            }
//        }
        if var objs = favoriteController.fetchedObjects, objs.count > 0 {
            for index in objs {
                if index.isMembership {
                    print(index.toMembership?.barcode)
                }
                if index.isCoupon {
                    print(index.toCoupon?.barcode)
                }
            }
            let item = objs[sourceIndexPath.row]
            let destinitem = objs[destinationIndexPath.row]
            print(item.toMembership?.barcode)
            print(destinitem.toMembership?.barcode)
            objs.remove(at: sourceIndexPath.row)
            objs.insert(item, at: destinationIndexPath.row)
            print(objs.count)
            for index in 0..<objs.count {
                //index 0은 최초 즐겨찾기가 생성되는 아이템을 위해 비워둠
                objs[index].index = Int32(index) + 1
                print(objs[index].index)
            }
            context.updatedObjects
            ad.saveContext()
        }
        
        isMovingItem = false
        
    }
    
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func configureCell(cell: FavoriteCell, indexPath: NSIndexPath) {
        
        //update cell
        
        let item = favoriteController.object(at: indexPath as IndexPath)
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
    
    func attemptFetch()  {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let typeSort = NSSortDescriptor(key: "isCoupon", ascending: true)
        let indexSort = NSSortDescriptor(key: "index", ascending: true)
        
        fetchRequest.sortDescriptors = [typeSort, dateSort, indexSort]
        
        
        let controller = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: context, sectionNameKeyPath: "isCoupon", cacheName: nil)
        
        //save시 tableview update를 위한 델리게이트 전달
        
        controller.delegate = self
        
        self.favoriteController = controller
        
        do {
            try controller.performFetch()
        } catch {
            let error = error as NSError
            print("\(error)")
        }
    }
    
    //컨트롤러가 바뀔때마다 테이블뷰 업데이트
    
    func controllerWillChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if isMovingItem {
            return
        }
        tableView.beginUpdates()
    }
    
    func controllerDidChangeContent(_ controller: NSFetchedResultsController<NSFetchRequestResult>) {
        if isMovingItem {
            return
        }
        tableView.endUpdates()
    }
    
    func controller(_ controller: NSFetchedResultsController<NSFetchRequestResult>, didChange sectionInfo: NSFetchedResultsSectionInfo, atSectionIndex sectionIndex: Int, for type: NSFetchedResultsChangeType) {
        if isMovingItem {
            return
        }
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
                print(indexPath.row)
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


