//
//  ViewController.swift
//  PlayAndRecordAudio
//
//  Created by Rocky on 2018/4/8.
//  Copyright © 2018年 Rocky. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    
    private var player:AVAudioPlayer?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController{
    
    
    private func sampleAVAudioPlayer(){
        
        guard let fileUrl = Bundle.main.url(forResource: "rock", withExtension: "mp3") else { return }
        
        do {
            player = try AVAudioPlayer(contentsOf: fileUrl)
        } catch let error {
            print("error with \(error)")
        }
        
        if let player = player {
            player.prepareToPlay()
        }
    }
}

