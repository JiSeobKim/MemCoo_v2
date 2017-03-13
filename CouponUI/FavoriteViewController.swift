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
    
    var favoriteController: NSFetchedResultsController<Favorite>!
    var favorites: [Favorite]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        setNavigationBarColor()
       self.navigationItem.leftBarButtonItem = self.editButtonItem
        //네비 폰트
//        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "NanumSquare", size: 24)!]
        

        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        attemptFetch()
        self.tableView.reloadData()
    }
    
    //
    // MARK: - TableView overriding
    //
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "FavoriteCell", for: indexPath) as! FavoriteCell
        configureCell(cell: cell, indexPath: indexPath as NSIndexPath)
        
        return cell
    }
    
    
    //cell 숫자 정의
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let sections = favoriteController.sections {
            let sectionInfo = sections[section]
            
            return sectionInfo.numberOfObjects
        }
        return 0
        
    }
    //section 숫자 정의
    override func numberOfSections(in tableView: UITableView) -> Int {
        if let sections = favoriteController.sections {
            return sections.count
        }
        let noDataLabel: UILabel = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: tableView.bounds.size.height))
        noDataLabel.text = "등록된 즐겨찾기가 없습니다. \r\n 즐겨찾는 아이템을 등록해 주세요."
        noDataLabel.textAlignment = .center
        noDataLabel.font = UIFont(name: noDataLabel.font.fontName, size: 12)
        noDataLabel.numberOfLines = 0
        noDataLabel.textColor = #colorLiteral(red: 0.501960814, green: 0.501960814, blue: 0.501960814, alpha: 1)
        tableView.backgroundView = noDataLabel
        
        return 0
    }
    //section title 정의
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
    
    //tableview editing style
    override func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        if tableView.isEditing {
            return .delete
        }
        
        return .none
    }
    
    //editing commit action
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            
            if var objs = favoriteController.fetchedObjects, objs.count > 0{
                let alert = UIAlertController(title: "즐겨찾기 삭제", message: "멤버십카드, 쿠폰 데이터는 삭제되지 않습니다.", preferredStyle: .alert)
                let delete = UIAlertAction(title: "삭제", style: .destructive) {
                    (_) in
                    let item = objs[indexPath.row]
                    item.toMembership?.favorite = false
                    item.toCoupon?.favorite = false
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
    
    //editing mode일때 안으로 indent시킬 것인지
    override func tableView(_ tableView: UITableView, shouldIndentWhileEditingRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //row 이동시 action 구현
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        
        attemptFetch()
        if var objects = self.favoriteController.fetchedObjects {
            self.favoriteController.delegate = nil
            let object = objects[sourceIndexPath.row]
            objects.remove(at: sourceIndexPath.row)
            objects.insert(object, at: destinationIndexPath.row)
            
            var index = Int32(1)
            
            for object in objects where index < objects.count + 1 {
                object.index = index
                index += 1
            }
            ad.saveContext()
            self.favoriteController.delegate = self
            attemptFetch()
        }
        
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
    
    //cell 표현
    
    func configureCell(cell: FavoriteCell, indexPath: NSIndexPath) {
        
        //update cell
        
        let item = favoriteController.object(at: indexPath as IndexPath)
        cell.configureCell(item: item)
        
    }
    
   
    
    //
    // MARK: - coreData 부분
    //
    func attemptFetch()  {
        let fetchRequest: NSFetchRequest<Favorite> = Favorite.fetchRequest()
        let dateSort = NSSortDescriptor(key: "created", ascending: false)
        let typeSort = NSSortDescriptor(key: "isCoupon", ascending: true)
        let indexSort = NSSortDescriptor(key: "index", ascending: true)
        
        fetchRequest.sortDescriptors = [typeSort, indexSort, dateSort]
        
        
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
    
    func setNavigationBarColor()  {
        self.navigationItem.leftBarButtonItem = self.editButtonItem
//        self.navigationController?.navigationBar.tintColor = UIColor.black
        self.navigationController?.navigationBar.isTranslucent = false
        self.navigationController?.navigationBar.isOpaque = true
//        self.navigationController?.navigationBar.backgroundColor = UIColor.white
    }
    
}


