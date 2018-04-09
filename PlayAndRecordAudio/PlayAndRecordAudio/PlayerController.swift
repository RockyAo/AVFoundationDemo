//
//  PlayerController.swift
//  PlayAndRecordAudio
//
//  Created by Rocky on 2018/4/9.
//  Copyright © 2018年 Rocky. All rights reserved.
//

import Foundation
import AVFoundation


final class PlayerController {
    
    private var playStatus:Bool = false
    
    private var players:Array<AVAudioPlayer>!
    
    init() {
        
        if let guitarPlayer = playerForFile("guitar"),
            let bassPlayer = playerForFile("bass"),
             let drumPlayer = playerForFile("drums"){
            players = [
                guitarPlayer,
                bassPlayer,
                drumPlayer
            ]
        }else{
            fatalError("音频初始化失败")
        }
    }
    
    var isPlaying:Bool {
        get{
            return playStatus
        }
    }
    
    func play() {
        if !playStatus {
            let delayTime = players[0].deviceCurrentTime + 0.01
            players.forEach { (p) in
                p.play(atTime: delayTime)
            }
            playStatus = true
        }
    }
    
    func stop() {
        if playStatus {
            players.forEach { (p) in
                p.stop()
                p.currentTime = 0.0
            }
            playStatus = false
        }
    }
    
    func adjustRate(_ rate:Float)  {
        
    }
    
    func adjustPan(_ pan:Float, forPlayerAtIndex index:Int)  {
        
    }
    
    func adjustVolume(_ pan:Float, forPlayerAtIndex index:Int)  {
        
    }
    
    private func playerForFile(_ fileName:String) -> AVAudioPlayer?{
        guard let fileUrl = Bundle.main.url(forResource: fileName, withExtension: "caf") else { return nil }
        
        var player:AVAudioPlayer?
        
        do {
            player = try AVAudioPlayer(contentsOf: fileUrl)
            player?.numberOfLoops = -1 //无限
            player?.enableRate = true
            player?.prepareToPlay()
        } catch let error {
            print("初始化音频播放器失败 \(error)")
        }
        
        return player
    }
}
