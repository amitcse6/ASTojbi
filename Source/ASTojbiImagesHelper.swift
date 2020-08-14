//
//  ASTojbiImagesHelper.swift
//  ASTojbi
//
//  Created by Amit on 14/8/20.
//

import Foundation
import UIKit

@available(iOS 9.0, *)
public class ASTojbiImagesHelper {
    private static var podsBundle: Bundle {
        return Bundle(for: self)
    }
    
    private static func imageFor(name imageName: String) -> UIImage {
        return UIImage.init(named: imageName, in: podsBundle, compatibleWith: nil)!
    }
    
    public static var ballImageName: UIImage {
        return imageFor(name: "ball")
    }
    
    public static var backgroundImageName: UIImage {
        return imageFor(name: "background")
    }
    
    public static var resetImageName: UIImage {
        return imageFor(name: "reset_button")
    }
    
    public static var muteImageName: UIImage {
        return imageFor(name: "tojbi_mute_button")
    }
    
    public static var soundImageName: UIImage {
        return imageFor(name: "sound_button")
    }
}
