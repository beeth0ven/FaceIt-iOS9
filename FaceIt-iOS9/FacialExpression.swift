//
//  FacialExpression.swift
//  FaceIt-iOS9
//
//  Created by luojie on 16/5/8.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import Foundation

struct FacialExpression {
    enum Eyes: Int {
        case Open, Close, Squinting
        
        mutating func toggle() {
            switch self {
            case .Open:
                self = .Close
            case .Close:
                self = .Open
            case .Squinting: break
            }
        }
    }
    
    enum EyeBrows: Int {
        case Relaxed, Normal, Furrowed
        
        mutating func moreRelaxed() {
            self = EyeBrows(rawValue: rawValue - 1) ?? .Relaxed
        }
        
        mutating func moreFurrowed() {
            self = EyeBrows(rawValue: rawValue + 1) ?? .Furrowed
        }
    }
    
    enum Mouth: Int {
        case Frown, Smirk, Neutral, Grin, Smile
        
        mutating func sadder() {
            self = Mouth(rawValue: rawValue - 1) ?? .Frown
        }
        mutating func happier() {
            self = Mouth(rawValue: rawValue + 1) ?? .Smile
        }
    }
    
    var eyes: Eyes
    var eyeBrowns: EyeBrows
    var mouth: Mouth
}