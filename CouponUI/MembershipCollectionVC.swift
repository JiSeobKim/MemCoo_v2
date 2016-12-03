//
//  FirstViewController.swift
//  UISample
//
//  Created by mino on 2016. 11. 11..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit

class MembershipCollectionVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    
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
        
        ad?.modifyCheck = 0
        //체크 변수 복구
        self.collectionView.reloadData()
        //컬렉션뷰 릴로드

        
    }
    
    
    
    @IBOutlet weak var TestLabel: UILabel!
    
    var paramTest : String?
    
    
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        //컬렉션 뷰 셀 갯수 생성
//구조체 통일 전
        return (ad?.membership.count)!
//구조체 통일 후
//        return (ad?.membershipName.count)!
        
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MembershipCollectionVCell
        // 설정할 cell 선택(빨간 "cell"은 어트리뷰트인스펙터의 identifier)
        
        
//구조체 통일 후
        cell.LogoShow.image = ad?.membership[indexPath.row].logo
        cell.LogoName.text = ad?.membership[indexPath.row].brand
        
        
//구조체 통일 전
//        cell.LogoShow.image = ad?.membershipLogo[indexPath.row]
//        cell.LogoName.text = ad?.membershipName[indexPath.row]
//        //로고의 이미지/ 텍스트 값 대입
        
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
//구조체 통일에선 이것만 필요
            
            
            
            
            
            ////////////////////////////////////////////////
//            let show = segue.destination as! ShowMembershipVC
//            // 'CollectionShowController'내 변수 사용하기
//            
//            show.barcode = ad?.barcode[indexPath.row]
//            show.image = (ad?.membershipLogo[indexPath.row]!)!
//            show.title = ad?.membershipName[indexPath.row]
//            
            //선택된 셀의 바코드와 로고, 이름 전달
            ////////////////////////////////////////////////
        }
    }
    
    @IBAction func unwindToMainViewController(segue : UIStoryboardSegue){
        //화면 되돌아오기 메소드
    }

    
    
    

    

}

