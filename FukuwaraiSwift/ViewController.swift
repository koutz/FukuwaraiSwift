//
//  ViewController.swift
//  FukuwaraiSwift
//
//  Created by Hiroshi Murata on 2015/03/25.
//  Copyright (c) 2015年 hmcreation. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var baseImageView: UIImageView!
    @IBOutlet weak var rightEyebrowImageView: PartRightEyebrowImageView!
    @IBOutlet weak var leftEyebrowImageView: PartLeftEyebrowImageView!
    @IBOutlet weak var rightEyeImageView: PartRightEyeImageView!
    @IBOutlet weak var leftEyeImageView: PartLeftEyeImageView!
    @IBOutlet weak var noseImageView: PartNoseImageView!
    @IBOutlet weak var mouthImageView: PartMouthImageView!
    
    private var movingView: PartImageView?

    override func viewDidLoad() {
        
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: Selector("handlePanGesture:"))
        panGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(panGestureRecognizer)
        
        let rotationGestureRecognizer = UIRotationGestureRecognizer(target: self, action: Selector("handleRotationGesture:"))
        rotationGestureRecognizer.delegate = self
        self.view.addGestureRecognizer(rotationGestureRecognizer)
        
        // Synthesizerを生成しておく。
        // ここで行わない場合、初めて顔部品を選択したときに生成されるが、音声再生までにタイムラグが発生する。
        SpeechSynthesizer.sharedInstance.setupSynthesizer()
    }

    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Touches
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        if self.movingView == nil {
            self.setupMovingView(touches: touches)
        }
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        
        self.movingView = nil
    }
    
    
    // MARK: - Motions
    
    override func motionBegan(motion: UIEventSubtype, withEvent event: UIEvent) {
        
        self.leftEyebrowImageView.moveRandomly()
        self.rightEyebrowImageView.moveRandomly()
        self.leftEyeImageView.moveRandomly()
        self.rightEyeImageView.moveRandomly()
        self.noseImageView.moveRandomly()
        self.mouthImageView.moveRandomly()
    }
    
    
    // MARK: - GestureRecognizer Action
    
    func handlePanGesture(recognizer: UIPanGestureRecognizer) {
        
        switch recognizer.state {
        case .Changed:
            if self.movingView == nil {
                // 部品ビュー以外の位置からドラッグを開始した場合は、部品ビューを触ったときに移動の対象にする。
                self.setupMovingView(recognizer: recognizer)
                
                // ドラッグ開始から部品ビューが特定されるまでの移動分をクリアする。
                recognizer.setTranslation(CGPointZero, inView: self.view)
            }
            
            if let movingView = self.movingView {
                movingView.handlePanGesture(recognizer)
            }
        
        case .Ended:
            self.movingView = nil
            
        default:
            break
        }
    }
    
    func handleRotationGesture(recognizer: UIRotationGestureRecognizer) {
        
        switch recognizer.state {
        case .Changed:
            if self.movingView == nil {
                // 部品ビュー以外の位置から回転を開始した場合は、部品ビューを触ったときに回転の対象にする。
                self.setupMovingView(recognizer: recognizer)
                
                // 回転開始時から部品ビューが特定されるまでの回転分をクリアする。
                recognizer.rotation = 0
            }
            
            if let movingView = self.movingView {
                movingView.handleRotationGesture(recognizer)
            }
        
        case .Ended:
            self.movingView = nil
            
        default:
            break
        }
    }
    
    
    // MARK: - GestureRecognizer Delegate
    
    func gestureRecognizer(gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWithGestureRecognizer otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        // ドラッグと回転を同時に行う。
        return true
    }
    
    
    // MARK: - Private
    
    // 移動・回転対称の部品ビューの設定
    private func setupMovingView(#recognizer: UIGestureRecognizer) {
    
        self.movingView = self.touchedPartImageView(recognizer: recognizer);
        if let movingView = self.movingView {
            movingView.setupForMoving()
        }
    }
    
    private func setupMovingView(#touches: NSSet) {
        
        self.movingView = self.touchedPartImageView(touches: touches)
        if let movingView = self.movingView {
            movingView.setupForMoving()
        }
    }

    // タッチ位置の部品ビュー取得
    private func touchedPartImageView(#recognizer: UIGestureRecognizer) -> PartImageView? {
    
        var partImageView: PartImageView? = nil
        
        for var i = 0; i < recognizer.numberOfTouches(); i++ {
            let location: CGPoint = recognizer.locationOfTouch(i, inView: self.view);
            if let view = self.view.hitTest(location, withEvent: UIEvent()) {
                if view is PartImageView {
                    partImageView = view as? PartImageView
                    break
                }
            }
        }
        
        return partImageView
    }
    
    private func touchedPartImageView(#touches: NSSet) -> PartImageView? {
        
        var partImageView: PartImageView? = nil
        
        if let touch = touches.anyObject() as? UITouch {
            if touch.view is PartImageView {
                partImageView = touch.view as? PartImageView
            }
        }
        
        return partImageView
    }
}

