//
//  CoinSoundProvider.swift
//  Coin Toss 3D
//
//  Created by Eduard Caziuc on 24/04/2018.
//  Copyright © 2018 Eduard Caziuc. All rights reserved.
//

import AVFoundation

struct CoinSoundProvider {
    
    var coinFlipSound: AVAudioPlayer?
    
    mutating func playCoinSound() {
        
        do {
            
            if let url = Bundle.main.path(forResource: "CoinFlip", ofType: "wav") {
                coinFlipSound = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: url))
            } else { print("Audio File not found") ; return }
            
            
            guard let aPlayer = coinFlipSound else { return }
            aPlayer.play()
            
        } catch let error {
            print("Audio file failed with an error: \(error.localizedDescription)")
        }
    }
}


