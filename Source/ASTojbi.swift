//
//  ASTojbi.swift
//  ASTojbi
//
//  Created by Amit on 14/8/20.
//

import UIKit

@available(iOS 9.0, *)
class ASTojbi: UIView {
    var storeBack:UIView!
    var backImageView: UIImageView!
    var tojbiLabel:UILabel!
    var leftLabel: UILabel!
    var soundButton:UIButton!
    var resetButton:UIButton!
    var container:UIView!
    
    var shapeLayerBg = CAShapeLayer()
    var fillColorBg : UIColor = UIColor.clear
    var strokeColorBg : UIColor = UIColor.red
    
    var counter:Int = 0
    var counterLimit:Int = 100
    var lineWidthBg : CGFloat = 3.0
    var clockwise:Bool = true
    var startAngle : Double = 0
    var radiusX : Double = 150
    var radiusY : Double = 250
    var allPoint:[CGPoint]!
    var ballSize=CGSize(width: 50, height: 50)
    var isTouchEnable=true
    var padding: CGFloat = 0
    var resetBoardInterval: TimeInterval = 0.5
    var tojbiPlayer: ASTojbiPlayer?
}

@available(iOS 9.0, *)
extension ASTojbi {
    func setSoundImage(_ sender:UIButton) -> Void {
        if sender.tag == 0 {
            sender.setImage(ASTojbiImagesHelper.muteImageName, for: .normal)
        }else{
            sender.setImage(ASTojbiImagesHelper.soundImageName, for: .normal)
        }
    }
    
    @objc func soundButtonPressed(_ sender:UIButton) -> Void {
        if sender.tag==0 {
            sender.tag=1
        }else{
            sender.tag=0
        }
        setSoundImage(sender)
    }
    
    @objc func didSelectRowAt(_ sender: ASTojbiGesture) -> Void {
        if isTouchEnable {
            if counter<counterLimit {
                counter += 1
                ballAnimation()
            }else{
                counter=counterLimit
            }
            resetResources()
        }
    }
    
    func resetResources() -> Void {
        if tojbiLabel != nil {
            tojbiLabel.text=String(counter)
        }
    }
    
    func animationStart(_start: Int, _index: Int, _imageView:UIImageView, _delay:Double) -> Void {
        _imageView.tag=_index+1
        UIView.animate(withDuration: _delay, delay: _delay, options: .curveEaseOut, animations: {
            let point=self.allPoint[_index]
            _imageView.frame = CGRect(x: point.x-self.ballSize.width/2, y: point.y-self.ballSize.height/2, width: self.ballSize.width, height: self.ballSize.height)
        }, completion: { finished in
            if _index<(self.allPoint.count-1) {
                if _index>=(self.allPoint.count-10) && _index<=(self.allPoint.count-1) {
                    _imageView.layer.zPosition = CGFloat(1)
                }
                self.animationStart(_start: _start, _index: _index+1, _imageView:_imageView, _delay: _delay)
            }else{
                if self.soundButton.tag == 1 {
                    //AudioServicesPlaySystemSound (systemSoundID)
                    //self.tojbiPlayer = ASTojbiPlayer("beep1", "mp3")
                    //self.tojbiPlayer?.play()
                }
                self.rearrangeTag()
            }
        })
    }
    
    func rearrangeTag() -> Void {
        let _delay=0.05
        for _index in stride(from: (allPoint.count-1), to: -1, by: -1) {
            if let _imageView = container.viewWithTag(_index+1) as? UIImageView {
                if _index==(self.allPoint.count-1) {
                } else if _index<(self.allPoint.count-1) {
                    let tag=_index+1
                    _imageView.tag=tag+1
                    _imageView.layer.zPosition = CGFloat((_imageView.tag))
                    UIView.animate(withDuration: _delay, delay: _delay, options: .curveEaseOut, animations: {
                        let point=self.allPoint[tag]
                        _imageView.frame = CGRect(x: point.x-self.ballSize.width/2, y: point.y-self.ballSize.height/2, width: self.ballSize.width, height: self.ballSize.height)
                    }, completion: { finished in
                    })
                }
            }
        }
        if let _imageView = container.viewWithTag((allPoint.count-1)+1) as? UIImageView {
            let tag=0
            _imageView.tag=tag+1
            _imageView.layer.zPosition = CGFloat((_imageView.tag))
            UIView.animate(withDuration: _delay, delay: _delay, options: .curveEaseOut, animations: {
                let point=self.allPoint[tag]
                _imageView.frame = CGRect(x: point.x-self.ballSize.width/2, y: point.y-self.ballSize.height/2, width: self.ballSize.width, height: self.ballSize.height)
            }, completion: { finished in
            })
        }
        isTouchEnable=true
    }
    
    func ballAnimation() -> Void {
        isTouchEnable=false
        let _index=(counterLimit-1)
        if let _imageView = container.viewWithTag(_index+1) as? UIImageView {
            animationStart(_start: _index, _index: _index+1, _imageView:_imageView, _delay:0.01)
        }
    }
}
