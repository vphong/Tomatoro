//
//  ProgressView.swift
//  Tomatoro
//
//  Created by Vanna Phong on 07/09/2018.
//  Copyright © 2018 vphong. All rights reserved.
//

import UIKit

@IBDesignable class ProgressView: UIView, CAAnimationDelegate {
    
    // MARK: - Properties
    fileprivate let animation = CABasicAnimation(keyPath: "strokeEnd")
    fileprivate var started = false
    fileprivate var duration = 0.0
    
    // lazy initalization
    @IBInspectable fileprivate lazy var backgroundTrack: CAShapeLayer = {
        return CAShapeLayer()
    }()
    @IBInspectable fileprivate lazy var foregroundTrack: CAShapeLayer = {
        return CAShapeLayer()
    }()
    
    @IBInspectable fileprivate lazy var backgroundDisc: CAShapeLayer = {
        return CAShapeLayer()
    }()
    
    // MARK: - Init Functions
    override init(frame: CGRect) {
        super.init(frame: frame)
        createLayers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createLayers()
    }
    
    // MARK: - Layers
    
    fileprivate func createLayers() {
        backgroundTrack = createTrack(color: UIColor.lightGray.withAlphaComponent(0.5).cgColor)
        foregroundTrack = createTrack(color: UIColor.white.cgColor)
        foregroundTrack.strokeEnd = 0.0
        foregroundTrack.transform = CATransform3DMakeRotation(-CGFloat.pi/2, 0, 0, 1)
        
        backgroundDisc.path = circularPath(radiusOffset: 20)
        backgroundDisc.fillColor = UIColor.white.withAlphaComponent(0.5).cgColor
        backgroundDisc.zPosition = -10
        
        backgroundDisc.shadowPath = circularPath(radiusOffset: 30)
        backgroundDisc.shadowColor = UIColor.black.cgColor
        backgroundDisc.opacity = 1.0
        backgroundDisc.shadowOffset = CGSize(width: 5, height: 5)
        backgroundDisc.shadowRadius = 10
        
        self.layer.addSublayer(backgroundTrack)
        self.layer.addSublayer(foregroundTrack)
        self.layer.addSublayer(backgroundDisc)
    }
    
    fileprivate func createTrack(color: CGColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        
        layer.path = circularPath(radiusOffset: 40)
        
        // styling
        layer.lineCap = kCALineCapRound
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = color
        layer.strokeStart = 0.0
        layer.strokeEnd = 1.0
        layer.lineWidth = 2.0
        
        return layer
    }
    
    override func layoutSubviews() {
        self.backgroundTrack.path = circularPath(radiusOffset: 40)
        self.foregroundTrack.path = circularPath(radiusOffset: 40)
        self.backgroundDisc.path = circularPath(radiusOffset: 20)
        
        foregroundTrack.frame = backgroundTrack.frame
        foregroundTrack.position = backgroundTrack.position
        foregroundTrack.position.y += self.frame.height
    }
    
    fileprivate func circularPath(radiusOffset: Double) -> CGPath {
        let center = CGPoint(x: self.frame.width/2, y: self.frame.width/2)
        let radius = self.frame.width/2 - CGFloat(radiusOffset)
        return UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
    }
    
    // MARK: - Animation
    public func setDuration(duration: Double) {
        self.duration = duration
    }
    
    public func start() {
        if !started {
            // start, from scratch
            setInitialAnimation()
            started = true
            
            animation.fromValue = 0.0
            animation.toValue = 1.0
            animation.duration = TimeInterval(duration)
            
            animation.fillMode = kCAFillModeForwards
            animation.isRemovedOnCompletion = false
            animation.isAdditive = true
            
            foregroundTrack.add(animation, forKey: "timerProgress")
        } else {
            // resume, from pause
            foregroundTrack.speed = 1.0
            
            // start animation from previous point
            foregroundTrack.beginTime = foregroundTrack.timeOffset
            
        }
    }
    
    public func pause() {
        foregroundTrack.speed = 0.0
        
        let pausedTime = foregroundTrack.convertTime(CACurrentMediaTime(), from: foregroundTrack)
        foregroundTrack.timeOffset = pausedTime
    }
    
    public func stop() {
        setInitialAnimation()
        foregroundTrack.removeAllAnimations()
    }
    
    fileprivate func setInitialAnimation() {
        started = false
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        foregroundTrack.speed = 1.0
        foregroundTrack.timeOffset = 0.0
        foregroundTrack.beginTime = 0.0
        foregroundTrack.strokeEnd = 0.0
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
}

extension CAShapeLayer {
    
}
