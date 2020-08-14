//
//  ASTojbiPlayer.swift
//  ASTojbi
//
//  Created by Amit on 14/8/20.
//

import Foundation
import AVFoundation

class ASTojbiPlayer: NSObject {
    var player: AVAudioPlayer?
    
    func playSound() {
        let url = ASTojbiPlayer.podsBundle.url(forResource: "beep1", withExtension: "mp3")!
        do {
            player = try AVAudioPlayer(contentsOf: url)
            guard let player = player else { return }

            player.prepareToPlay()
            player.play()

        } catch let error as NSError {
            print(error.description)
        }
    }
    
    private static var podsBundle: Bundle {
        return Bundle(for: self)
    }
}
