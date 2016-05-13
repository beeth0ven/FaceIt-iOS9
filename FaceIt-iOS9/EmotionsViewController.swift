//
//  EmotionsViewController.swift
//  FaceIt-iOS9
//
//  Created by luojie on 16/5/13.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

class EmotionsViewController: UIViewController {
    
    var expressions = [
        "Angry": FacialExpression(eyes: .Close, eyeBrowns: .Furrowed, mouth: .Frown),
        "Happy": FacialExpression(eyes: .Open, eyeBrowns: .Normal, mouth: .Smile),
        "Worried": FacialExpression(eyes: .Open, eyeBrowns: .Relaxed, mouth: .Smirk),
        "Mischievious": FacialExpression(eyes: .Open, eyeBrowns: .Furrowed, mouth: .Grin)
    ]
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if let
            identifier = segue.identifier,
            nav = segue.destinationViewController as? UINavigationController,
            fvc = nav.topViewController as? FaceViewController,
            expression = expressions[identifier] {
            fvc.expression = expression
            fvc.title = identifier
        }
    }
}
