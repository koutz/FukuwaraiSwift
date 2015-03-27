//
//  PartImageView.swift
//  FukuwaraiSwift
//
//  Created by Hiroshi Murata on 2015/03/26.
//  Copyright (c) 2015年 hmcreation. All rights reserved.
//

import UIKit

class PartImageView: UIImageView {
    
    private var currentTransform: CGAffineTransform = CGAffineTransformIdentity
    private var part: Part

    required init(coder aDecoder: NSCoder) {
        self.part = Part()
        super.init(coder: aDecoder)
    }
    
    // 移動
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
        // 移動した距離を取得
        var translation = recognizer.translationInView(self.superview!)
        // 移動した距離だけ部品を移動させる。
        var location = CGPointMake(self.center.x + translation.x, self.center.y + translation.y)
        self.center = location
        
        // translationInView: が返す距離は、ドラッグが始まってからの累積値となるため、ドラッグで移動した距離を初期化する。
        recognizer.setTranslation(CGPointZero, inView: self.superview!)
    }
    
    // 回転
    func handleRotationGesture(recognizer: UIRotationGestureRecognizer) {
        
        var transform = CGAffineTransformRotate(self.currentTransform, recognizer.rotation)
        self.transform = transform
    }
    
    // 移動前の設定
    func setupForMoving() {
        
        // タッチ時SE再生
        self.part.playTouchSE()
        
        // 一番手前へ移動
        self.superview!.bringSubviewToFront(self)
        
        // 回転処理のために、現在のtransformプロパティを保持
        self.currentTransform = self.transform
    }
    
    // ランダムに移動
    func moveRandomly() {
    
        let x = CGFloat(arc4random() % UInt32(self.superview!.frame.size.width))
        let y = CGFloat(arc4random() % UInt32(self.superview!.frame.size.height))
        let degrees = CGFloat(arc4random() % UInt32(360))
        let radians = CGFloat((degrees / 360.0) * 2.0 * CGFloat(M_PI))
        let transform = CGAffineTransformRotate(self.currentTransform, radians)
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.center = CGPointMake(x, y)
            self.transform = transform
        })
    }
}


// MARK: - Subclasses

class PartLeftEyebrowImageView: PartImageView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.part = PartLeftEyebrow()
    }
}

class PartRightEyebrowImageView: PartImageView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.part = PartRightEyebrow()
    }
}

class PartLeftEyeImageView: PartImageView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.part = PartLeftEye()
    }
}

class PartRightEyeImageView: PartImageView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.part = PartRightEye()
    }
}

class PartNoseImageView: PartImageView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.part = PartNose()
    }
}

class PartMouthImageView: PartImageView {
    
    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.part = PartMouth()
    }
}