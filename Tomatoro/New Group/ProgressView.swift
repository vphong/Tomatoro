//
//  ProgressView.swift
//  Tomatoro
//
//  Created by Vanna Phong on 07/09/2018.
//  Copyright © 2018 vphong. All rights reserved.
//

import UIKit

class ProgressView: UIView {
    
    // MARK: - Properties
    private let animation = CABasicAnimation()
    
    private lazy var trackLayer: CAShapeLayer = {
        return CAShapeLayer()
    }()
    private lazy var progressLayer: CAShapeLayer = {
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
    
    // MARK: - Layer logic
    
    private func createLayers() {
        trackLayer = createLayer(color: UIColor.lightGray.cgColor)
        progressLayer = createLayer(color: UIColor.cyan.cgColor)
        
        self.layer.addSublayer(trackLayer)
        self.layer.addSublayer(progressLayer)
    }
    
    private func createLayer(color: CGColor) -> CAShapeLayer {
        let layer = CAShapeLayer()
        
        setLayerPath(layer: layer)
        
        // styling
        layer.lineCap = kCALineCapRound
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = color
        layer.strokeStart = 0
        layer.strokeEnd = 1
        layer.lineWidth = 2
        
        return layer
    }
    
    
    override func layoutSubviews() {
        setLayerPath(layer: self.trackLayer)
        setLayerPath(layer: self.progressLayer)
    }
    
    private func setLayerPath(layer: CAShapeLayer) {
        let center = CGPoint(x: self.frame.width/2, y: self.frame.width/2)
        print(center)
        let radius = self.frame.width/2 - 40
        let startAngle = -CGFloat.pi / 2
        let endAngle = 3 * CGFloat.pi / 2
        layer.path = UIBezierPath(arcCenter: center, radius: radius, startAngle: startAngle, endAngle: endAngle, clockwise: true).cgPath
    }
    
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
}
