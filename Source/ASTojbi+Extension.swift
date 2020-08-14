//
//  ASTojbi+Extension.swift
//  ASTojbi
//
//  Created by Amit on 14/8/20.
//

import Foundation
import UIKit

@available(iOS 9.0, *)
extension ASTojbi {
    static func imageWithColor(_image:UIImage, _color: UIColor) -> UIImage {
        let maskImage = _image.cgImage
        let size=_image.size
        let width = size.width
        let height = size.height
        let bounds = CGRect(x: 0, y: 0, width: width, height: height)
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bitmapInfo = CGBitmapInfo(rawValue: CGImageAlphaInfo.premultipliedLast.rawValue)
        let context = CGContext(data: nil, width: Int(width), height: Int(height), bitsPerComponent: 8, bytesPerRow: 0, space: colorSpace, bitmapInfo: bitmapInfo.rawValue)!
        
        context.clip(to: bounds, mask: maskImage!)
        context.setFillColor(_color.cgColor)
        context.fill(bounds)
        
        if let cgImage = context.makeImage() {
            let coloredImage = UIImage(cgImage: cgImage)
            return coloredImage
        } else {
            return _image
        }
    }
}
