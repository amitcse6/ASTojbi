//
//  ASTojbiClassic.swift
//  ASTojbi
//
//  Created by Amit on 14/8/20.
//

import Foundation
import UIKit

@available(iOS 9.0, *)
public class ASTojbiClassic: ASTojbi { 
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.initialize()
    }
    
    override init(frame:CGRect) {
        super.init(frame: frame)
        self.initialize()
    }
    
    func initialize() {
        backgroundColor = .white
        loadStoreBack()
        loadBackgroundImage()
        resetBoardWith(resetBoardInterval)
    }
    
    func loadStoreBack() -> Void {
        storeBack = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: frame.height))
        storeBack.backgroundColor = .gray
        addSubview(storeBack)
        
        storeBack.translatesAutoresizingMaskIntoConstraints = false
        storeBack.topAnchor.constraint(equalTo: topAnchor, constant: padding).isActive = true
        storeBack.leftAnchor.constraint(equalTo: leftAnchor, constant: padding).isActive = true
        storeBack.rightAnchor.constraint(equalTo: rightAnchor, constant: -padding).isActive = true
        storeBack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -padding).isActive = true
    }
    
    func loadBackgroundImage() -> Void {
        backImageView = UIImageView()
        backImageView.contentMode = .scaleToFill
        backImageView.image = ASTojbiImagesHelper.backgroundImageName
        storeBack.addSubview(backImageView)
        
        backImageView.translatesAutoresizingMaskIntoConstraints = false
        backImageView.topAnchor.constraint(equalTo: storeBack.topAnchor, constant: padding).isActive = true
        backImageView.leftAnchor.constraint(equalTo: storeBack.leftAnchor, constant: padding).isActive = true
        backImageView.rightAnchor.constraint(equalTo: storeBack.rightAnchor, constant: -padding).isActive = true
        backImageView.bottomAnchor.constraint(equalTo: storeBack.bottomAnchor, constant: -padding).isActive = true
    }
    
    func resetBoardWith(_ interval: TimeInterval) -> Void {
        self.perform(#selector(self.resetBoardAfter(_:)), with: nil, afterDelay: interval)
    }
    
    @objc func resetBoardAfter(_ sender:Any) {
        counter=0
        loadContainer()
        loadBall()
        loadButton()
    }
    
    func loadContainer() -> Void {
        if container != nil {
            container.removeFromSuperview()
            container=nil
        }
        container=UIView(frame: CGRect(x: 0, y: 0, width: self.storeBack.frame.width, height: self.storeBack.frame.height))
        self.storeBack.addSubview(container)
        container.backgroundColor=UIColor.clear
        
        container.translatesAutoresizingMaskIntoConstraints = false
        container.topAnchor.constraint(equalTo: storeBack.topAnchor, constant: padding).isActive = true
        container.leftAnchor.constraint(equalTo: storeBack.leftAnchor, constant: padding).isActive = true
        container.rightAnchor.constraint(equalTo: storeBack.rightAnchor, constant: -padding).isActive = true
        container.bottomAnchor.constraint(equalTo: storeBack.bottomAnchor, constant: -padding).isActive = true
        
        allPoint = pointsWith(container.frame.size)
        allPoint.removeAll()
        do{
            startAngle = ASTojbi.getDegToRad(_deg:-90)
            shapeLayerBg.fillColor = fillColorBg.cgColor
            shapeLayerBg.strokeColor = strokeColorBg.cgColor
            shapeLayerBg.lineWidth = lineWidthBg
            container.layer.insertSublayer(shapeLayerBg, at: 0)
            let centerPoint=CGPoint(x: container.frame.width/2, y: container.frame.height/2)
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
            path.close()
            shapeLayerBg.path = path.cgPath
        }
    }
    
    func loadBall() -> Void {
        for n in 0..<allPoint.count {
            if n<counterLimit {
                let point=allPoint[n]
                let ballImageView = UIImageView(frame: CGRect(x: point.x-ballSize.width/2, y: point.y-ballSize.height/2, width: ballSize.width, height: ballSize.height))
                container.addSubview(ballImageView)
                ballImageView.tag=n+1
                ballImageView.layer.zPosition = CGFloat((ballImageView.tag))
                ballImageView.contentMode = .scaleToFill
                var image = ASTojbiImagesHelper.ballImageName
                if n == 0 {
                    image = ASTojbi.imageWithColor(_image: image, _color: UIColor(red: 255/255.0, green: 0/255.0, blue: 0/255.0, alpha: 1.0))
                }
                ballImageView.image=image
            }
        }
    }
    
    func loadButton() -> Void {
        leftLabel = UILabel()
        container.addSubview(leftLabel)
        tojbiLabel=leftLabel
        leftLabel.numberOfLines=0
        leftLabel.textColor = .red
        leftLabel.textAlignment = .center
        
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        leftLabel.centerXAnchor.constraint(equalTo: container.centerXAnchor).isActive = true
        leftLabel.centerYAnchor.constraint(equalTo: container.centerYAnchor).isActive = true
        
        soundButton = UIButton()
        container.addSubview(soundButton)
        soundButton.addTarget(self, action: #selector(soundButtonPressed(_:)), for: .touchUpInside)
        soundButtonPressed(soundButton)
        
        soundButton.translatesAutoresizingMaskIntoConstraints = false
        soundButton.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -8).isActive = true
        soundButton.bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -8).isActive = true
        soundButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        soundButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        resetButton = UIButton()
        container.addSubview(resetButton)
        resetButton.setImage(ASTojbiImagesHelper.resetImageName, for: .normal)
        resetButton.addTarget(self, action: #selector(resetButtonPressed(_:)), for: .touchUpInside)
        
        resetButton.translatesAutoresizingMaskIntoConstraints = false
        resetButton.rightAnchor.constraint(equalTo: container.rightAnchor, constant: -8).isActive = true
        resetButton.bottomAnchor.constraint(equalTo: soundButton.topAnchor, constant: -8).isActive = true
        resetButton.widthAnchor.constraint(equalToConstant: 50).isActive = true
        resetButton.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        container.tag=0
        let tapGesture = ASTojbiGesture()
        tapGesture.addTarget(self, action:  #selector(didSelectRowAt(_:)))
        tapGesture.numberOfTapsRequired = 1
        container.addGestureRecognizer(tapGesture)
    }
    
    @objc func resetButtonPressed(_ sender:UIButton) -> Void {
        resetBoardWith(resetBoardInterval)
    }
}
