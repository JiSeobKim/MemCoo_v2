//
//  CustomNavi.swift
//  MemCoo
//
//  Created by kimjiseob on 09/11/2018.
//  Copyright © 2018 mino. All rights reserved.
//

import UIKit

class CustomNavi: UINavigationBar {

//    override init(frame: CGRect) {
//        super.init(frame: frame)
//        setColor()
//    }
//
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//        setColor()
//
//        super.init(coder: aDecoder)
//    }
    
    let searchController = UISearchController(searchResultsController: nil)
    let refreshControl = UIRefreshControl()

    
//     Only override draw() if you perform custom drawing.
//     An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        setColor()
    }
 
    
    
    
    func setColor() {
        self.setLightTheme = true
        self.layer.masksToBounds = false
        self.layer.shadowColor = UIColor.lightGray.cgColor
        self.layer.shadowOpacity = 0.3
        self.layer.shadowOffset = CGSize(width: 0, height: 1.5)
        self.layer.shadowRadius = 2
    }

}
