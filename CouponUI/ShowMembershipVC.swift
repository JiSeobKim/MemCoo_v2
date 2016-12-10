//
//  collectionViewController.swift
//  UISample
//
//  Created by 김지섭 on 2016. 11. 11..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit

class ShowMembershipVC: UIViewController {

    var cellData : MembershipClass?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        

        self.ShowBarcode.image = cellData?.barcodeImage
        //imageView에 바코드 이미지 입력
        self.navigationItem.title = cellData?.brand
        //Label에 브랜드명 입력
        
        self.ShowBarcode.image = cellData?.barcodeImage
        
        
        
        // 바코드 자릿수에 따라 4자리마다 " - " 표시 해주기
        //var barcode = (ad.membership[(ad.showNow)!].barcode)!
        
        var barcode = (cellData?.barcode)!
        
        
        
        let stringCount = barcode.characters.count
        if stringCount > 5 {
            barcode = barcode.insert(string: "-", ind: 4)
        }
            if stringCount > 9 {
                barcode = barcode.insert(string: "-", ind: 9)
            }
            if stringCount > 14 {
                barcode = barcode.insert(string: "-", ind: 14)
            }
        barcodeLabel.text = barcode
        ShowLogo.image = cellData?.logo
        //        barcodeLabel.text = barcode
//        ShowLogo.image = ad.membership[(ad.showNow)!].logo
        
       
       
        
       
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //수정시 값 되불러 오기
        //방식 차이( viewDidLoad:선택된 셀로부터 값 받기 / viewWillAppear: 앱델리게이트에 저장된 값 받기)
        if ad.modifyCheck == true {
            self.ShowBarcode.image = cellData?.barcodeImage
            self.ShowLogo.image = cellData?.logo

            


        }
    }
    
    
    


    var image = UIImage()
    
    @IBOutlet weak var ShowLogo: UIImageView!
    @IBOutlet weak var barcodeLabel: UILabel!
    @IBOutlet weak var ShowBarcode: UIImageView!

    
    
   
    
    
//    @IBAction func modify(_ sender: Any) {
//        // 수정 버튼
//        ad.modifyCheck = true
//        // 수정 버튼으로 들어가는지 확인 할 변수
//        if let uvc = self.storyboard?.instantiateViewController(withIdentifier: "AddTab")
//            // 전환할 뷰 컨트롤러의 StoryBoard ID 정보를 객체화
//        {
//            cellData?.modify = true
//            
//            self.navigationController?.pushViewController(uvc, animated: true)
//            //화면전환
//        }
//        
//        
//    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MembershipEdit" {
            let vc = segue.destination as? AddEditMemebershipVC
            vc?.cellData = self.cellData
            vc?.cellData?.modify = true
            
        }
    }

    
    
    
    
 
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}


