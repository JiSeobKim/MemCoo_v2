//
//  FavoriteFlagView.swift
//  MemebershipCoupon
//
//  Created by Joosung Kim on 12/03/2017.
//  Copyright © 2017 mino. All rights reserved.
//

import UIKit

class MemcooView: NSObject {
 
    //MARK: - Canvas Drawings
    
    /// Symbols
    
    class func drawFavoriteFlagForTableCell(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 51, height: 51), resizing: ResizingBehavior = .aspectFit) {
        /// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        /// Resize to Target Frame
        context.saveGState()
        let resizedFrame = resizing.apply(rect: CGRect(x: 0, y: 0, width: 51, height: 51), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 51, y: resizedFrame.height / 51)
        
        /// Rectangle 4
        let rectangle4 = UIBezierPath()
        rectangle4.move(to: CGPoint.zero)
        rectangle4.addLine(to: CGPoint(x: 51, y: 0))
        rectangle4.addLine(to: CGPoint(x: 0, y: 51))
        rectangle4.addLine(to: CGPoint.zero)
        rectangle4.close()
        rectangle4.move(to: CGPoint.zero)
        context.saveGState()
        rectangle4.usesEvenOddFillRule = true
        UIColor(hue: 0.461, saturation: 0.34, brightness: 0.843, alpha: 1).setFill()
        rectangle4.fill()
        context.restoreGState()
        
        context.restoreGState()
    }
    
    
    //MARK: - Canvas Images
    
    /// Symbols
    
    class func imageOfFavoriteFlagForTableCell() -> UIImage {
        struct LocalCache {
            static var image: UIImage!
        }
        if LocalCache.image != nil {
            return LocalCache.image
        }
        var image: UIImage
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 51, height: 51), false, 0)
        MemcooView.drawFavoriteFlagForTableCell()
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        LocalCache.image = image
        return image
    }
    
    
    //MARK: - Resizing Behavior
    
    enum ResizingBehavior {
        case aspectFit /// The content is proportionally resized to fit into the target rectangle.
        case aspectFill /// The content is proportionally resized to completely fill the target rectangle.
        case stretch /// The content is stretched to match the entire target rectangle.
        case center /// The content is centered in the target rectangle, but it is NOT resized.
        
        func apply(rect: CGRect, target: CGRect) -> CGRect {
            if rect == target || target == CGRect.zero {
                return rect
            }
            
            var scales = CGSize.zero
            scales.width = abs(target.width / rect.width)
            scales.height = abs(target.height / rect.height)
            
            switch self {
            case .aspectFit:
                scales.width = min(scales.width, scales.height)
                scales.height = scales.width
            case .aspectFill:
                scales.width = max(scales.width, scales.height)
                scales.height = scales.width
            case .stretch:
                break
            case .center:
                scales.width = 1
                scales.height = 1
            }
            
            var result = rect.standardized
            result.size.width *= scales.width
            result.size.height *= scales.height
            result.origin.x = target.minX + (target.width - result.width) / 2
            result.origin.y = target.minY + (target.height - result.height) / 2
            return result
        }
    }
}
