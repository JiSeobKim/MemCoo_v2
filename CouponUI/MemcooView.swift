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
    
    class func drawLogoSelectButton(frame targetFrame: CGRect = CGRect(x: 0, y: 0, width: 155, height: 155), resizing: ResizingBehavior = .aspectFit) {
        /// General Declarations
        let context = UIGraphicsGetCurrentContext()!
        
        /// Resize to Target Frame
        context.saveGState()
        let resizedFrame = resizing.apply(rect: CGRect(x: 0, y: 0, width: 155, height: 155), target: targetFrame)
        context.translateBy(x: resizedFrame.minX, y: resizedFrame.minY)
        context.scaleBy(x: resizedFrame.width / 155, y: resizedFrame.height / 155)
        
        /// Group
        do {
            context.saveGState()
            
            /// Oval Copy 10
            let ovalCopy10 = UIBezierPath()
            ovalCopy10.move(to: CGPoint(x: 77.5, y: 155))
            ovalCopy10.addCurve(to: CGPoint(x: 155, y: 155), controlPoint1: CGPoint(x: 101.6, y: 155), controlPoint2: CGPoint(x: 155, y: 155))
            ovalCopy10.addLine(to: CGPoint(x: 155, y: 77.5))
            ovalCopy10.addCurve(to: CGPoint(x: 77.5, y: 0), controlPoint1: CGPoint(x: 155, y: 34.7), controlPoint2: CGPoint(x: 120.3, y: 0))
            ovalCopy10.addCurve(to: CGPoint(x: 0, y: 77.5), controlPoint1: CGPoint(x: 34.7, y: 0), controlPoint2: CGPoint(x: 0, y: 34.7))
            ovalCopy10.addCurve(to: CGPoint(x: 77.5, y: 155), controlPoint1: CGPoint(x: 0, y: 120.3), controlPoint2: CGPoint(x: 34.7, y: 155))
            ovalCopy10.close()
            ovalCopy10.move(to: CGPoint(x: 77.5, y: 155))
            context.saveGState()
            context.saveGState()
            ovalCopy10.lineWidth = 6
            context.beginPath()
            context.addPath(ovalCopy10.cgPath)
            context.clip(using: .evenOdd)
            UIColor(hue: 0.053, saturation: 0.858, brightness: 0.965, alpha: 0.78).setStroke()
            ovalCopy10.stroke()
            context.restoreGState()
            context.restoreGState()
            
            /// edit
            let edit = NSMutableAttributedString(string: "edit")
            edit.addAttribute(NSFontAttributeName, value: UIFont(name: ".AppleSDGothicNeoI-SemiBold", size: 13)!, range: NSRange(location: 0, length: edit.length))
            edit.addAttribute(NSForegroundColorAttributeName, value: UIColor(hue: 0.06, saturation: 0.842, brightness: 0.969, alpha: 0.78), range: NSRange(location: 0, length: edit.length))
            edit.addAttribute(NSKernAttributeName, value: -0.31, range: NSRange(location: 0, length: edit.length))
            do {
                let paragraphStyle = NSMutableParagraphStyle()
                paragraphStyle.alignment = .right
                edit.addAttribute(NSParagraphStyleAttributeName, value: paragraphStyle, range: NSRange(location: 0, length: edit.length))
            }
            context.saveGState()
            edit.draw(in: CGRect(x: 124.96, y: 134.57, width: 25.23, height: 15))
            context.restoreGState()
            
            context.restoreGState()
        }
        
        context.restoreGState()
    }
    
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
    
    class func imageOfLogoSelectButton() -> UIImage {
        struct LocalCache {
            static var image: UIImage!
        }
        if LocalCache.image != nil {
            return LocalCache.image
        }
        var image: UIImage
        
        UIGraphicsBeginImageContextWithOptions(CGSize(width: 155, height: 155), false, 0)
        MemcooView.drawLogoSelectButton()
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        
        LocalCache.image = image
        return image
    }
    
    
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
