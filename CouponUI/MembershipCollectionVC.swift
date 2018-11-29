//
//  FirstViewController.swift
//  UISample
//
//  Created by mino on 2016. 11. 11..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit
import CoreData
import TesseractOCR
import RxCocoa
import RxSwift

class MembershipCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, NSFetchedResultsControllerDelegate, UIGestureRecognizerDelegate, UICollectionViewDelegateFlowLayout, G8TesseractDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    
    //
    //model
    //
    @IBOutlet weak var collectionView: UICollectionView!
    var controller: NSFetchedResultsController<Membership>!
    var fetchData : [Membership]? = [] {
        didSet {
            showData = fetchData
            self.collectionView.reloadData()
        }
    }
    var showData : [Membership]? = []
    
    var originalImage: UIImage!
    let imagePicker = UIImagePickerController()

    
    let searchController = UISearchController(searchResultsController: nil)
    let refreshControl = UIRefreshControl()
    
    let dispose = DisposeBag()
    
    var predicate: NSPredicate?
    
    //
    //viewLoad
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        imagePicker.delegate = self
        attemptFetch()
        
        //롱프레스
        let lpgr : UILongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(MembershipCollectionVC.handleLongPress(_:)))
        lpgr.minimumPressDuration = 0.5
        lpgr.delegate = self
        lpgr.delaysTouchesBegan = true
        self.collectionView?.addGestureRecognizer(lpgr)
      
        
        
        
        if #available(iOS 11.0, *) {
            searchController.obscuresBackgroundDuringPresentation = false
            definesPresentationContext = true
            
            self.navigationItem.searchController = searchController
        }
        
        
        searchController.searchBar.rx.text.orEmpty.subscribe(onNext: {[unowned self] query in
            guard self.fetchData?.count != 0 else { return }

            let convertedQuery = query.lowercased()

            self.showData = self.fetchData?.filter {
                let compare = $0.toBrand?.title?.lowercased()
                return (compare?.hasPrefix(convertedQuery) ?? false)
            }
            self.collectionView.reloadData()
        }).disposed(by: dispose)
        
        
        
        
        
        
        self.parent?.view.backgroundColor = .white
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        attemptFetch()
        self.collectionView.reloadData()
        
        
        
    }
    
   
    
    @objc func handleLongPress(_ gestureReconizer: UILongPressGestureRecognizer) {
        if gestureReconizer.state != UIGestureRecognizer.State.began {
            return
        }
        
        let p = gestureReconizer.location(in: collectionView)
        let indexPath = collectionView.indexPathForItem(at: p)
        
        if let index = indexPath {
            _ = collectionView.cellForItem(at: index)
            // do stuff with your cell, for example print the indexPath
            print(index.row)
            
            
            
            if let item = showData?[index.row] {
                print(item.favorite)
                
                if item.favorite == false {
                    let alert = UIAlertController(title: "즐겨찾기 추가", message: "\"\((item.toBrand?.title)!)\" 멤버십을 \n즐겨찾기에 추가하시겠습니까?", preferredStyle: .alert)
                    let add = UIAlertAction(title: "추가", style: .default) {
                        (_) in
                        let favoriteContext = Favorite(context: context)
                        item.favorite = true
                        
                        favoriteContext.isMembership = true
                        favoriteContext.isCoupon = false
                        favoriteContext.index = 0
                        item.toFavorite = favoriteContext
                        ad.saveContext()
                        self.collectionView.reloadData()
                    }
                    
                    let cancel = UIAlertAction(title: "취소", style: .cancel)
                    alert.addAction(add)
                    alert.addAction(cancel)
                    self.present(alert, animated: true)
                }
                if item.favorite == true {
                    let alert = UIAlertController(title: "즐겨찾기 제거", message: "\"\((item.toBrand?.title)!)\" 멤버십을 \n즐겨찾기에서 제거하시겠습니까?", preferredStyle: .alert)
                    let add = UIAlertAction(title: "제거", style: .default) {
                        (_) in
                        
                        item.favorite = false
                        context.delete(item.toFavorite!)
                        
                        ad.saveContext()
                        self.collectionView.reloadData()
                    }
                    
                    let cancel = UIAlertAction(title: "취소", style: .cancel)
                    alert.addAction(add)
                    alert.addAction(cancel)
                    self.present(alert, animated: true)
                }
            }
            
        } else {
            print("Could not find index path(longPress)")
        }
    }
    
    
    
    
    //
    //controller
    //
    
    //컬렉션 뷰 셀 갯수 생성
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return showData?.count ?? 0
    }
    
    //셀 재사용을 위한 정의
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        // 설정할 cell 선택(빨간 "viewcell"은 어트리뷰트인스펙터의 identifier)
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewcell", for: indexPath) as! MembershipCollectionVCell
        
        configureCell(cell: cell, indexPath: indexPath)
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = UIScreen.main.bounds.width
        let calcurate = (width - 80) / 3
        return CGSize(width: calcurate, height: calcurate) // width & height are the same to make a square cell
    }
    
    //셀 생성 정의
    func configureCell(cell: MembershipCollectionVCell, indexPath: IndexPath) {
        
        let innerView = cell.contentView.viewWithTag(1)
        innerView?.layer.applyCellBolderLayout()
        cell.layer.applyCellShadowLayout()
        
        //update cell
        guard let item = showData?[indexPath.row] else { return }
        cell.configureCell(item: item)
    }
    
    //선택된 셀을 사용하기위한 정의
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = showData?[indexPath.row] else { return }
        performSegue(withIdentifier: "showCollection", sender: item)
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
    
    //추가 버튼
    
    
    @IBAction func btnAdd(_ sender: Any) {
        let alert = UIAlertController(title: "멤버십 추가", message: "멤버십을 추가할 방식을 선택해주세요.", preferredStyle: .actionSheet)
        
        //컬러가 바뀌어서 주석처리했습니다.
        //        alert.view.tintColor = UIColor.black
        
    
        
        let ocr = UIAlertAction(title: "바코드 이미지에서 텍스트 추출", style: .default) {
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
            
            if let addVC = self.storyboard?.instantiateViewController(withIdentifier: "MembershipAddEditTab") {
                self.navigationController?.pushViewController(addVC, animated: true)
            }
        }
        
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
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
                if let addVC = self.storyboard?.instantiateViewController(withIdentifier: "MembershipAddEditTab") as? AddEditMemebershipVC {
                    addVC.originalImage = self.originalImage
                    self.navigationController?.pushViewController(addVC, animated: true)
                }
            }
        }
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
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
            self.fetchData = controller.fetchedObjects
        } catch {
            let error = error as NSError
            print("\(error)")
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



extension MembershipCollectionVC: UISearchBarDelegate {
    
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchController.isActive = false
        //        let temp = searchBar.text
        //        searchBar.endEditing(true)
        //        searchBar.showsCancelButton = false
        //
        //        searchBar.text = temp
    }
    
    
}
