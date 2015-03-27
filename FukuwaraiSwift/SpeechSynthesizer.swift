//
//  SpeechSynthesizer.swift
//  FukuwaraiSwift
//
//  Created by Hiroshi Murata on 2015/03/27.
//  Copyright (c) 2015年 hmcreation. All rights reserved.
//

import UIKit
import AVFoundation

final class SpeechSynthesizer: NSObject {

    class var sharedInstance: SpeechSynthesizer {
        struct Static {
            static let instance: SpeechSynthesizer = SpeechSynthesizer()
        }
        return Static.instance
    }
    
    private var synthesizer = AVSpeechSynthesizer()
    
    private override init() {
    
        super.init()
    }
    
    func stopSpeakingAtBoundary(boundary: AVSpeechBoundary) -> Bool {
    
        return self.synthesizer.stopSpeakingAtBoundary(boundary)
    }
    
    func speakUtterance(utterance: AVSpeechUtterance) {
    
        self.synthesizer.speakUtterance(utterance)
    }
}
