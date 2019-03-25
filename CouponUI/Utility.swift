//
//  Utility.swift
//  MemCoo
//
//  Created by JiseobKim on 04/03/2019.
//  Copyright © 2019 mino. All rights reserved.
//

import UIKit
import Lottie
class Utility {
    class func getTopVC() -> UIViewController? {
        return ad.window?.rootViewController
    }
    
    // Animation Lottie - Favorite
    class func startPopAnimation(type: LottieList) {
        
        
        let popView = AnimationView(name: type.rawValue)
        
        switch type {
        case .favorite, .hart, .brokenStar, .disLike:
            popView.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
        case .blast :
            popView.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        case .check, .done:
            popView.frame = CGRect(x: 0, y: 0, width: 250, height: 250)
        }
        
        guard let vc = Utility.getTopVC() else { return }
        
        popView.center = vc.view.center
        vc.view.addSubview(popView)
        popView.play(completion: { (_) in
            popView.removeFromSuperview()
        })
    }
    
}



enum LottieList: String{
    case favorite = "LottieStar"
    case hart = "LottieHart"
    case brokenStar = "LottieBrokenStar"
    case disLike = "LottieDisLike"
    case blast = "LottieBlast"
    case check = "LottieCheck"
    case done = "LottieDone"
}
