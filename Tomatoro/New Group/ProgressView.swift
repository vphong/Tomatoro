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
    @IBInspectable fileprivate lazy var trackLayer: CAShapeLayer = {
        return CAShapeLayer()
    }()
    @IBInspectable fileprivate lazy var progressLayer: CAShapeLayer = {
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
        trackLayer = createLayer(color: UIColor.lightGray.cgColor)
        progressLayer = createLayer(color: UIColor.cyan.cgColor)
        progressLayer.strokeEnd = 0.0
        
        progressLayer.transform = CATransform3DMakeRotation(-CGFloat.pi / 2, 0, 0, 1)
        
        self.layer.addSublayer(trackLayer)
        self.layer.addSublayer(progressLayer)
    }
    
    fileprivate func createLayer(color: CGColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        
        setLayerPath(layer: layer)
        
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
        setLayerPath(layer: self.trackLayer)
        setLayerPath(layer: self.progressLayer)
        
        progressLayer.frame = trackLayer.frame
        progressLayer.position = trackLayer.position
        progressLayer.position.y += self.frame.height
    }
    
    fileprivate func setLayerPath(layer: CAShapeLayer) {
        let center = CGPoint(x: self.frame.width/2, y: self.frame.width/2)
        let radius = self.frame.width/2 - 40
        layer.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: 0, endAngle: CGFloat.pi * 2, clockwise: true).cgPath
        
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
            
            progressLayer.add(animation, forKey: "timerProgress")
        } else {
            // resume, from pause
            progressLayer.speed = 1.0
            
            // start animation from previous point
            progressLayer.beginTime = progressLayer.timeOffset
            
        }
    }
    
    public func tick(to progress: Double) {
        animation.toValue = CGFloat(progress)
    }
    
    public func pause() {
        progressLayer.speed = 0.0
        
        let pausedTime = progressLayer.convertTime(CACurrentMediaTime(), from: progressLayer)
        progressLayer.timeOffset = pausedTime
    }
    
    public func stop() {
        setInitialAnimation()
        progressLayer.removeAllAnimations()
    }
    
    fileprivate func setInitialAnimation() {
        started = false
        progressLayer.speed = 1.0
        progressLayer.timeOffset = 0.0
        progressLayer.beginTime = 0.0
        progressLayer.strokeEnd = 0.0
        
        animation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        animation.fromValue = 0.0
        animation.duration = TimeInterval(duration)
        
        animation.fillMode = kCAFillModeForwards
        animation.isRemovedOnCompletion = false
        animation.isAdditive = true
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
}
