//
//  SoundManager.swift
//  WorkoutApp
//
//  Created by Leon Grimmeisen on 19.12.23.
//

import Foundation
import AVKit

class SoundManager {

    static let instance = SoundManager()
    
    var player: AVAudioPlayer?
    
    enum SoundOption: String {
        case dadam, countdown, jubilant
    }
    
    func playSound(sound: SoundOption) {
        guard let url = Bundle.main.url(forResource: sound.rawValue, withExtension: "mp3") else { return }
        
        do {
            try AVAudioSession.sharedInstance().setCategory(AVAudioSession.Category.playback, options: AVAudioSession.CategoryOptions.mixWithOthers)
        } catch(let error) {
            print(error.localizedDescription)
        }
                
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch {
            print("Error playing sound... \(error.localizedDescription)")
        }
    }
    
    func pauseSound() {
        player?.pause()
    }
    
    func stopSound() {
        player?.stop()
        player?.currentTime = 0
    }
    
    func resumeSound() {
        player?.play()
    }
}
