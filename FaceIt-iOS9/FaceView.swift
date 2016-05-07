//
//  FaceView.swift
//  FaceIt-iOS9
//
//  Created by luojie on 16/5/7.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

@IBDesignable
class FaceView: UIView {
    
    
    @IBInspectable var scale: CGFloat = 0.9
    @IBInspectable var mouthCurvature: Double = 1

    private var skullRadius: CGFloat { return scale * min(bounds.width, bounds.height) / 2 }
    private var skullCenter: CGPoint { return CGPoint(x: bounds.midX, y: bounds.midY) }
    
    private struct Ratios {
        static let SkullRadiusToEyeOffset: CGFloat = 3
        static let SkullRadiusToEyeRadius: CGFloat = 10
        static let SkullRadiusToMouthWidth: CGFloat = 1
        static let SkullRadiusToMouthHeight: CGFloat = 3
        static let SkullRadiusToMouthOffset: CGFloat = 3
    }
    
    private enum Eye {
        case Left, Right
    }
    
    private func pathForCicleCenterAt(center: CGPoint, radius: CGFloat) -> UIBezierPath {
        let path = UIBezierPath(
            arcCenter: center,
            radius: radius,
            startAngle: 0,
            endAngle: CGFloat(2 * π),
            clockwise: true
        )
        path.lineWidth = 5
        return path
    }
    
    private func getEyeCenter(eye: Eye) -> CGPoint {
        let eyeOffset = skullRadius / Ratios.SkullRadiusToEyeOffset
        var eyeCenter = skullCenter
        eyeCenter.y -= eyeOffset
        switch eye {
        case .Left: eyeCenter.x -= eyeOffset
        case .Right: eyeCenter.x += eyeOffset
        }
        return eyeCenter
    }
    
    private func pathForEye(eye: Eye) -> UIBezierPath {
        let eyeRadius = skullRadius / Ratios.SkullRadiusToEyeRadius
        let center = getEyeCenter(eye)
        return pathForCicleCenterAt(center, radius: eyeRadius)
    }
    
    private func pathForMouth() -> UIBezierPath {
        let mouthWidth = skullRadius / Ratios.SkullRadiusToMouthWidth
        let mouthHeight = skullRadius / Ratios.SkullRadiusToMouthHeight
        let mouthOffset = skullRadius / Ratios.SkullRadiusToMouthOffset
        
        let rect = CGRect(x: skullCenter.x - mouthWidth/2, y: skullCenter.y + mouthOffset, width: mouthWidth, height: mouthHeight)
        
        
        let smileOffset = CGFloat(max(-1, min(mouthCurvature, 1))) * rect.height
        let startPoint = rect.origin
        let endPoint = CGPoint(x: rect.maxX, y: rect.minY)
        let cp1 = CGPoint(x: rect.minX + mouthWidth/3, y: rect.minY + smileOffset)
        let cp2 = CGPoint(x: rect.maxX - mouthWidth/3, y: rect.minY + smileOffset)
        let path = UIBezierPath(curveStartPoint: startPoint, endPoint: endPoint, controlPoint1: cp1, controlPoint2: cp2)
        path.lineWidth = 5
        return path
    }
    
    override func drawRect(rect: CGRect) {
        UIColor.blueColor().set()
        pathForCicleCenterAt(skullCenter, radius: skullRadius).stroke()
        pathForEye(.Left).stroke()
        pathForEye(.Right).stroke()
        pathForMouth().stroke()
    }
}

extension UIBezierPath {
    convenience init(curveStartPoint startPoint: CGPoint, endPoint: CGPoint, controlPoint1: CGPoint, controlPoint2: CGPoint) {
        self.init()
        moveToPoint(startPoint)
        addCurveToPoint(endPoint, controlPoint1: controlPoint1, controlPoint2: controlPoint2)
    }
}

let π = M_PI
