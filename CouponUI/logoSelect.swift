
 //  Created by 김지섭 on 2016. 12. 10..
 //  Copyright © 2016년 김지섭. All rights reserved.
 //
 
 import Foundation
 import UIKit
 class logoSelect : UIViewController, UINavigationControllerDelegate, UITableViewDelegate, UITableViewDataSource{
    
    var delegate : logoData?
    
    override func viewDidLoad() {
        navigationController?.delegate = self
        addLogoAtArray()
    }
    
    //선택된 테이블 셀 번호/그 내부에서 선택된 셀
    var selectedTagInfo : Int?
    var selectedImgInfo : Int?
    
    var storedOffsets = [Int: CGFloat]()
    
    var logo : Array = ["통신사","카페","옷","화장품","포인트","편의점"]
    var telecommunicationLogo : [UIImage] = []
    var cafeLogo : [UIImage] = []
    var clothLogo : [UIImage] = []
    var cosmeticLogo : [UIImage] = []
    var pointLogo : [UIImage] = []
    var convenienceLogo : [UIImage] = []
    
   
 
    
    func addLogoAtArray()->(){
        //for 문을 통한 로고들 추가
        for row in 1...10 {
            if UIImage(named:"telecommunication\(row)") != nil {
                telecommunicationLogo.append(UIImage(named:"telecommunication\(row)")!)
            }
            
            if UIImage(named:"cafe\(row)") != nil {
                cafeLogo.append(UIImage(named:"cafe\(row)")!)
            }
            
            if UIImage(named:"clothes\(row)") != nil {
                clothLogo.append(UIImage(named:"clothes\(row)")!)
            }
            
            if UIImage(named:"cosmetic\(row)") != nil {
                cosmeticLogo.append(UIImage(named:"cosmetic\(row)")!)
            }
            
            if UIImage(named:"point\(row)") != nil {
                pointLogo.append(UIImage(named:"point\(row)")!)
            }
            
            if UIImage(named:"convenience\(row)") != nil {
                convenienceLogo.append(UIImage(named:"convenience\(row)")!)
            }
        }
    }
    func allcategory(_ data:Int) ->  Array<Any>{
        //모든 카테고리들을 한 배열에 추가
        let allcategory  = [self.telecommunicationLogo,self.cafeLogo,self.clothLogo,self.cosmeticLogo,self.pointLogo,self.convenienceLogo]
        
        
        return allcategory[data]
        
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //테이블뷰 프로토콜
        return 6
    }
    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        //테이블뷰 프로토콜
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryCell", for: indexPath) as! logoTableCell
        
        cell.category.text = logo[indexPath.row]
        
        cell.setCollectionViewDataSourceDelegate(self, forRow: indexPath.row)
        
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //컬렉션뷰 좌우 스크롤 후 테이블뷰 상하 스크롤 하여도 컬렉션뷰 위치 저장을 위함
        //설명이 어려우므로 쪽지 주세요
        guard let tableViewCell = cell as? logoTableCell else { return }
        
        tableViewCell.collectionViewOffset = storedOffsets[indexPath.row] ?? 0
    }
    
    func tableView(_ tableView: UITableView, didEndDisplaying cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        //컬렉션뷰 좌우 스크롤 후 테이블뷰 상하 스크롤 하여도 컬렉션뷰 위치 저장을 위함
        //설명이 어려우므로 쪽지 주세요
        guard let tableViewCell = cell as? logoTableCell else {return}
        
        storedOffsets[indexPath.row] = tableViewCell.collectionViewOffset
    }

    
    
    
    
    
    
    
    
 }
 
 extension logoSelect : UICollectionViewDelegate, UICollectionViewDataSource {
    //컬렉션뷰 프로토콜 확장
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allcategory(collectionView.tag).count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "choiceCell", for: indexPath) as! logoCollectionCell
        
        
        let logoArray = allcategory(collectionView.tag)[indexPath.row] as! UIImage
        cell.logo.image = logoArray
        
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //셀 선택시 하이라이트

        
        selectedTagInfo = collectionView.tag
        selectedImgInfo = indexPath.row
        
        if selectedImgInfo != nil {
            let logoArray = allcategory(selectedTagInfo!)[selectedImgInfo!] as! UIImage
            self.delegate?.updataData(data: logoArray )
            _ = self.navigationController?.popViewController(animated: true)
        }

        
        
        
        
    }
    
   
    
    
 }
 
 

 

 
 
 
 
 
 
 
