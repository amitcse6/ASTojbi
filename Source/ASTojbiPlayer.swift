//
//  ASTojbiPlayer.swift
//  ASTojbi
//
//  Created by Amit on 14/8/20.
//

import Foundation
import AVFoundation

class ASTojbiPlayer: NSObject {
    private var audioPlayer: AVPlayer?
    
    init(_ string: String) {
        guard let url = URL(string: string) else {
            print("error to load the mp3 file")
            return
        }
        do {
            audioPlayer = try AVPlayer(url: url as URL)
        }catch {
            print("audio file error")
        }
    }
    
    init(_ forResource: String, _ withExtension: String) {
        guard let url = ASTojbiPlayer.podsBundle.url(forResource: forResource, withExtension: withExtension) else {
            print("error to get the mp3 file")
            return
        }
        do {
            audioPlayer = try AVPlayer(url: url)
        }catch {
            print("audio file error")
        }
    }
    
    func play() {
        print("audioPlayer: \(audioPlayer)")
        audioPlayer?.play()
    }
    
    private static var podsBundle: Bundle {
        return Bundle(for: self)
    }
}
