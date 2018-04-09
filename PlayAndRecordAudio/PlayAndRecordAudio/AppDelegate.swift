//
//  AppDelegate.swift
//  PlayAndRecordAudio
//
//  Created by Rocky on 2018/4/8.
//  Copyright © 2018年 Rocky. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.

//        setAVAudioSessionCategory()
        
        return true
    }

    private func setAVAudioSessionCategory() {
        
        let audioSession = AVAudioSession.sharedInstance()
        
        do {
            
            try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            try audioSession.setActive(true)
            
        } catch let error {
            print("设置音频会话失败 \(error)")
        }
    }
}

