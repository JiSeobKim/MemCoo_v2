//
//  FirstViewController.swift
//  UISample
//
//  Created by mino on 2016. 11. 11..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit

class MembershipCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    //test
    //test2
    @IBOutlet weak var collectionView: UICollectionView!
    //CollectionView 이름 선언
    //45,71,88 라인에서 사용
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    var ad = UIApplication.shared.delegate as? AppDelegate
    //델리게이트내 변수 사용을 위해 선언
    
    
    
    
    override func viewWillAppear(_ animated: Bool) {
                // 뷰2->뷰1는 viewDidLoad로 못함
        
        ad?.modifyCheck = false
        //체크 변수 복구
        self.collectionView.reloadData()
        //컬렉션뷰 릴로드
        ad?.showNow = nil
        //선택된 번호 초기화 (컬렉션 뷰에서 선택된 셀 번호에 주로 사용)
        
    }
    
    
    
   
    
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //컬렉션 뷰 셀 갯수 생성
        return (ad?.membership.count)!

        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "viewcell", for: indexPath) as! MembershipCollectionVCell
        // 설정할 cell 선택(빨간 "viewcell"은 어트리뷰트인스펙터의 identifier)
        
        
        cell.viewLogoShow.image = ad?.membership[indexPath.row].logo
        cell.viewLogoName.text = ad?.membership[indexPath.row].brand
        //로고의 이미지/ 텍스트 값 대입
        
        
  
        return cell
        
    }


    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showCollection"
        {
            
            let indexPaths = self.collectionView.indexPathsForSelectedItems!
            let indexPath = indexPaths[0] as NSIndexPath
            //선택된 셀
            ad?.showNow = indexPath.row
            //Appdelegate에 선택된 셀 번호 전달
        }
    }
    

    
    
    

    

}

