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
    
    @IBOutlet weak var playButton: UIButton!
    
    private let playerController = PlayerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
    }
}


// MARK: - Response Method
extension ViewController {
    
    @IBAction func adjustPan(_ sender: UISlider) {
        print(sender)
        
        playerController.adjustPan(sender.value, forPlayerAtIndex: sender.tag)
    }
    
    @IBAction func adjustVolume(_ sender: UISlider) {
        print(sender)
        playerController.adjustVolume(sender.value, forPlayerAtIndex: sender.tag)
    }
    
    @IBAction func adjustRate(_ sender: UISlider) {
        print(sender)
        playerController.adjustRate(sender.value)
    }
    
    @IBAction func playOrStop(_ sender: UIButton) {
        
        playerController.isPlaying ? playerController.stop() : playerController.play()
        playerController.isPlaying ? sender.setTitle("stop", for: .normal) : sender.setTitle("play", for: .normal)
    }
}

extension ViewController{
    
    ///AVAudioPlayer的简单使用
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

