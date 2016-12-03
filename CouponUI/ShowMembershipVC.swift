//
//  collectionViewController.swift
//  UISample
//
//  Created by 김지섭 on 2016. 11. 11..
//  Copyright © 2016년 mino. All rights reserved.
//

import UIKit

class ShowMembershipVC: UIViewController {

   
    override func viewDidLoad() {
        super.viewDidLoad()
        
//구조체 통일
        self.ShowBarcode.image = ad?.membership[(ad?.showNow)!].barcodeImage
        //imageView에 바코드 이미지 입력
        self.ShowName.text = ad?.membership[(ad?.showNow)!].brand
        //Label에 브랜드명 입력
        //test
        
////구조체 통일 전
//        self.ShowBarcode.image = ad?.fromString(string: String(describing: barcode))
//        //바코드 이미지로 변환
//        self.ShowName.text = self.title
//        //전달받은 string 띄우기
        
        
        

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //수정시 값 되불러 오기
        //방식 차이( viewDidLoad:선택된 셀로부터 값 받기 / viewWillAppear: 앱델리게이트에 저장된 값 받기)
        if ad?.modifyCheck == 1 {
////구조체 통일 전
            self.ShowBarcode.image = ad?.membership[(ad?.showNow)!].barcodeImage
            self.ShowName.text = ad?.membership[(ad?.showNow)!].brand
            
////구조체 통일 후
//            self.ShowBarcode.image = ad?.fromString(string: String(describing: ad?.barcode[(ad?.showNow)!]))
//            self.ShowName.text = ad?.membershipName[(ad?.showNow)!]

        }
    }
    
    

    var ad = UIApplication.shared.delegate as? AppDelegate
    //AppDelegate 사용
    
    @IBOutlet weak var ShowName: UILabel!
    @IBOutlet weak var ShowBarcode: UIImageView!
    
    @IBAction func modify(_ sender: Any) {
        // 수정 버튼
        ad?.modifyCheck = 1
        // 수정 버튼으로 들어가는지 확인 할 변수
        if let uvc = self.storyboard?.instantiateViewController(withIdentifier: "AddTab")
            // 전환할 뷰 컨트롤러의 StoryBoard ID 정보를 객체화
        {
            self.navigationController?.pushViewController(uvc, animated: true)
            //화면전환
        }
    }
    
    var image = UIImage()
    var barcode : Int?

    
    
    
    
    
    // 바코드 이미지로 변환 함수
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
