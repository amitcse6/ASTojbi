//
//  ASTojbi+Math.swift
//  ASTojbi
//
//  Created by Amit on 14/8/20.
//

import Foundation

@available(iOS 9.0, *)
extension ASTojbi { 
    func pointsWith(_ size: CGSize) -> [CGPoint] {
        var allPoint = [CGPoint]()
        let centerPoint=CGPoint(x: size.width/2, y: size.height/2)
        let desiredLimit=120
        let path = UIBezierPath()
        let interval=360.0/Double(desiredLimit)
        for n in 0..<desiredLimit {
            let degree=interval*Double(n)
            let coss = cos(degree * Double.pi / 180)
            let sinus = sin(degree * Double.pi / 180)
            let x=Double(radiusX)*coss
            let y=Double(radiusY)*sinus
            let point = CGPoint(x: Double(centerPoint.x)+x, y: Double(centerPoint.y)+y)
            if n == 0 {
                path.move(to: point)
            }else{
                path.addLine(to: point)
            }
            allPoint.append(point)
        }
        return allPoint
    }
    
    static func getDegToRad(_deg:Double) -> Double {
        return _deg*(Double.pi/180.0)
    }
}
