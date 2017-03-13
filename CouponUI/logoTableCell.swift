//
//  logoseletionCell.swift
//  StoryboardTest
//
//  Created by 김지섭 on 2016. 12. 14..
//  Copyright © 2016년 김지섭. All rights reserved.
//

import Foundation
import UIKit

class logoTableCell : UITableViewCell {
    @IBOutlet weak var category: UILabel!
    
    @IBOutlet weak var categoryCollection: UICollectionView!
    
    
}

extension logoTableCell {
    
    
    func setCollectionViewDataSourceDelegate<D: UICollectionViewDataSource & UICollectionViewDelegate>(_ dataSouceDelegate: D , forRow row: Int) {
        //CollectionView in TableView를 위한 코드
        categoryCollection.delegate = dataSouceDelegate
        categoryCollection.dataSource = dataSouceDelegate
        categoryCollection.tag = row
        categoryCollection.setContentOffset(categoryCollection.contentOffset, animated: false)
        categoryCollection.reloadData()
        


    }
    
    var collectionViewOffset: CGFloat {
        //이것을 해야 테이블뷰 스크롤 해도 위치가 저장되어있음
        //설명이 어렵네요 궁금하시면 텔레그램 주세요
        get{
            return categoryCollection.contentOffset.x
        }
        
        set {
            categoryCollection.contentOffset.x = newValue
        }
    }
    
    
    
}
