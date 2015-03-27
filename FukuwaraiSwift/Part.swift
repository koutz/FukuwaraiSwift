//
//  Part.swift
//  FukuwaraiSwift
//
//  Created by Hiroshi Murata on 2015/03/27.
//  Copyright (c) 2015年 hmcreation. All rights reserved.
//

import UIKit
import AVFoundation

class Part: NSObject {
    
    var speechText: String {
        return ""
    }
   
    func playTouchSE() {
        
        // 直前に再生されてる効果音を停止
        SpeechSynthesizer.sharedInstance.stopSpeakingAtBoundary(AVSpeechBoundary.Immediate)
        
        // 再生テキストなど設定
        var utterance = AVSpeechUtterance(string: self.speechText)
        let voice = AVSpeechSynthesisVoice(language: "ja-JP")
        utterance.voice = voice
        utterance.rate = 0.2
        
        // 再生開始
        SpeechSynthesizer.sharedInstance.speakUtterance(utterance)
    }
}

class PartLeftEyebrow: Part {
    
    override var speechText: String {
        return "左まゆげ"
    }
}

class PartRightEyebrow: Part {
    
    override var speechText: String {
        return "右まゆげ"
    }
}

class PartLeftEye: Part {
    
    override var speechText: String {
        return "左目"
    }
}

class PartRightEye: Part {
    
    override var speechText: String {
        return "右目"
    }
}

class PartNose: Part {
    
    override var speechText: String {
        return "鼻"
    }
}

class PartMouth: Part {
    
    override var speechText: String {
        return "口"
    }
}