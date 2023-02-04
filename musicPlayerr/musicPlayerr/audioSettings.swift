//
//  audioSettings.swift
//  um
//
//  Created by riley dou on 2023/1/10.
//

import Foundation
import AVKit
import AVFoundation

class audioSettings: ObservableObject {
    
    var audioPlayer: AVAudioPlayer?
    var playing = false
    @Published var playValue: TimeInterval = 0.0
    var playerDuration: TimeInterval = 0.0
    var timer = Timer.publish(every: 0.5, on: .main, in: .common).autoconnect()
    
    func playSound(sound: String) {
        if let url = Bundle.main.url(forResource: sound, withExtension: "mp3") {
        if playing == false {
                if (audioPlayer == nil) {
                        
                    audioPlayer = try! AVAudioPlayer(contentsOf: url)
                    audioPlayer?.prepareToPlay()
                    
                    audioPlayer?.play()
                    playing = true
                }
                }
        if playing == false {
            audioPlayer!.play()
            playing = true
            
            }
            playerDuration = audioPlayer?.duration ?? 0.00
        }
        
    }

    func stopSound() {
        //   if playing == true {
        audioPlayer?.stop()
        audioPlayer = nil
        playing = false
        playValue = 0.0
        //   }
    }
    
    func pauseSound() {
        if playing == true {
            audioPlayer?.pause()
            playing = false
        }
    }
    
    func changeSliderValue() {
        if playing == true {
            pauseSound()
            audioPlayer?.currentTime = playValue
            
        }
        
        if playing == false {
            audioPlayer?.play()
            playing = true
        }
    }
}
