//
//  ViewController.swift
//  01_SpeachSynthesizer
//
//  Created by Rocky on 2018/4/8.
//  Copyright © 2018年 Rocky. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    let synthesizer:AVSpeechSynthesizer = AVSpeechSynthesizer()
    
    let speechString:Array<String> = ["语音转换",
                                      "你好","测试"]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        
        speechString.forEach { (str) in
            
            let utterance = AVSpeechUtterance(string: str)
            
            utterance.voice = AVSpeechSynthesisVoice(language: "zh-cn")
            
            utterance.rate = 0.4
            
            utterance.pitchMultiplier = 0.8
            
            utterance.postUtteranceDelay = 0.1
            
            self.synthesizer.speak(utterance)
        }
    }
}

