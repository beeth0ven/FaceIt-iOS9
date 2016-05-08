//
//  FaceViewController.swift
//  FaceIt-iOS9
//
//  Created by luojie on 16/5/7.
//  Copyright © 2016年 LuoJie. All rights reserved.
//

import UIKit

class FaceViewController: UIViewController {
    
    private var expression = FacialExpression(eyes: .Open, eyeBrowns: .Normal, mouth: .Smile) { didSet { updateUI() } }

    @IBOutlet weak var faceView: FaceView! { didSet { updateUI() } }
    
    @IBAction func happier(sender: UISwipeGestureRecognizer) {
        expression.mouth.happier()
    }
    
    @IBAction func sadder(sender: UISwipeGestureRecognizer) {
        expression.mouth.sadder()
    }
    
    @IBAction func toggleEyes(sender: UITapGestureRecognizer) {
        if sender.state == .Ended {
            expression.eyes.toggle()
        }
    }
    
    private var mouthCurvatures: [FacialExpression.Mouth: Double] = [
        .Frown: -1.0,
        .Grin: 0.5,
        .Smile: 1.0,
        .Smirk: -0.5,
        .Neutral: 0.0
    ]
    
    private var eyeBrownTilts: [FacialExpression.EyeBrows: Double] = [
        .Relaxed: 0.5,
        .Furrowed: -0.5,
        .Normal: 0.0
    ]

    private func updateUI() {
        switch expression.eyes {
        case .Open: faceView.eyesOpen = true
        case .Close: faceView.eyesOpen = false
        case .Squinting: faceView.eyesOpen = true
        }
        faceView.mouthCurvature = mouthCurvatures[expression.mouth] ?? 0
        faceView.eyeBrowTilt = eyeBrownTilts[expression.eyeBrowns] ?? 0
    }
}

