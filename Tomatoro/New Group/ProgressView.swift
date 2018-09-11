//
//  ProgressView.swift
//  Tomatoro
//
//  Created by Vanna Phong on 07/09/2018.
//  Copyright © 2018 vphong. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    private let animation = CABasicAnimation()
    
    private var radius: CGFloat = 0
    
    private lazy var trackLayer: CAShapeLayer = {
        return CAShapeLayer()
    }()
    private lazy var progressLayer: CAShapeLayer = {
        return CAShapeLayer()
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.radius = self.frame.width/2
        addLayers()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.radius = self.frame.width/2
        addLayers()
    }
    
    
    private func addLayers() {
        trackLayer = createLayer(color: UIColor.lightGray.cgColor)
        progressLayer = createLayer(color: UIColor.cyan.cgColor)
        
        self.layer.addSublayer(trackLayer)
        self.layer.addSublayer(progressLayer)
        
    }

    private func animate() {
        let animation = CABasicAnimation()
        
        animation.toValue = 1
        
    }
    
    
    private func createLayer(color: CGColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        
        // path
//        let center = CGPoint(x: self.frame.midX, y: self.frame.midY)
//        let center = C
        let startAngle = -CGFloat.pi / 2
        let endAngle = 3 * CGFloat.pi / 2
        layer.path = UIBezierPath(arcCenter: self.center, radius: self.radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
//        layer.position = center
        
        // styling
        layer.lineCap = kCALineCapRound
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = color
        layer.strokeStart = 0
        layer.strokeEnd = 1
        layer.lineWidth = 10
//        layer.position = CGPoint(x: self.bounds.minX, y: self.bounds.minY)
        
        return layer
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.radius = self.frame.width/2
        trackLayer.frame = self.bounds
        progressLayer.frame = self.bounds
        let layerCenter = CGPoint(x: self.center.x - self.radius/3, y: self.center.y - self.radius)
        trackLayer.position = layerCenter
        progressLayer.position = layerCenter

    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
}
