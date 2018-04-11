//
//  PlayerController.swift
//  PlayAndRecordAudio
//
//  Created by Rocky on 2018/4/9.
//  Copyright © 2018年 Rocky. All rights reserved.
//

import Foundation
import AVFoundation

protocol PlayerControlelrDelegate:class {
    
    func playbackStop()
    func playbackBegan()
}


final class PlayerController {
    
    private var playStatus:Bool = false
    
    private var players:Array<AVAudioPlayer>!
    
    var isPlaying:Bool {
        get{
            return playStatus
        }
    }
    
    weak var delegate:PlayerControlelrDelegate?
    
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
        
        let center = NotificationCenter.default
        
        center.addObserver(self,
                           selector: #selector(handleInterruption(notification:)),
                           name: Notification.Name.AVAudioSessionInterruption,
                           object: AVAudioSession.sharedInstance())
        
        center.addObserver(self,
                           selector: #selector(handleRouteChange(notification:)),
                           name: Notification.Name.AVAudioSessionRouteChange,
                           object: AVAudioSession.sharedInstance())
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
        players.forEach { (p) in
            p.rate = rate
        }
    }
    
    func adjustPan(_ pan:Float, forPlayerAtIndex index:Int)  {
        if isValidIndex(index) {
            let p = players[index]
            p.pan = pan
        }
    }
    
    func adjustVolume(_ volume:Float, forPlayerAtIndex index:Int)  {
        if isValidIndex(index) {
            let p = players[index]
            p.volume = volume
        }
    }
    
    private func isValidIndex(_ index:Int) -> Bool {
        return index == 0 || index < self.players.count
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
    
    ///处理中断通知
    @objc private func handleInterruption(notification:Notification){
        guard let info = notification.userInfo ,
                let type = info[AVAudioSessionInterruptionTypeKey] as? AVAudioSessionInterruptionType else { return }
        
        if type == .began {
            stop()
            if let delegate = self.delegate {
                delegate.playbackStop()
            }
        }else{
            
            guard let options = info[AVAudioSessionInterruptionOptionKey] as? AVAudioSessionInterruptionOptions else { return }
            
            if options == .shouldResume{
                play()
                
                if let delegate = self.delegate {
                    delegate.playbackBegan()
                }
            }
        }
    }
    
    ///处理线路改变
    @objc private func handleRouteChange(notification:Notification){
        guard let info = notification.userInfo ,
                let reason = info[AVAudioSessionRouteChangeReasonKey] as? AVAudioSessionRouteChangeReason
            else { return  }
        
        if reason == .oldDeviceUnavailable {
            
            guard let previesRoute = info[AVAudioSessionRouteChangePreviousRouteKey] as? AVAudioSessionRouteDescription,
                    let previousOutput = previesRoute.outputs.first else { return }
            
            if previousOutput.portType == AVAudioSessionPortHeadphones {
                stop()
                if let delegate = self.delegate {
                    delegate.playbackStop()
                }
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
