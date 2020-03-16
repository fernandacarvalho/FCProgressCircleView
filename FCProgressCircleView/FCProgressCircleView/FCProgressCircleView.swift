//
//  FCProgressCircleView.swift
//  FCProgressCircleView
//
//  Created by Fernanda Carvalho on 10/03/20.
//  Copyright © 2020 FernandaCarvalho. All rights reserved.
//

import Foundation
import UIKit

public protocol FCCircleViewDelegate: NSObjectProtocol {
    func animationDidEnd()
}

@IBDesignable
public class FCProgressCircleView: UIView, CAAnimationDelegate
{
    fileprivate var circleLayer: CAShapeLayer!
    fileprivate var percentageLabel: UILabel?
    
    open var showPercentageLabel: Bool = true
    open var delegate: FCCircleViewDelegate?
    
    public init(frame: CGRect, lineWidth: CGFloat?)
    {
        super.init(frame: frame)
        
        let path = UIBezierPath(arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0), radius: (frame.size.width)/2, startAngle: 0.0, endAngle: CGFloat(.pi * 2.0), clockwise: true)
        self.setupCircleLayer(with: path, and: lineWidth ?? 5.0)
    }

    required init?(coder aDecoder: NSCoder)
    {
        fatalError("init(coder:) has not been implemented")
    }
    
    fileprivate func setupCircleLayer(with circlePath: UIBezierPath, and lineWidth: CGFloat) {
        self.circleLayer = CAShapeLayer()
        self.circleLayer.path = circlePath.cgPath
        self.circleLayer.fillColor = UIColor.clear.cgColor
        self.circleLayer.strokeColor = UIColor.clear.cgColor
        self.circleLayer.lineWidth = lineWidth
        self.circleLayer.strokeEnd = 0.0
        self.layer.addSublayer(self.circleLayer)
        if self.showPercentageLabel {
            self.addPercentageLabel()
        }
    }
    fileprivate func addPercentageLabel() {
        self.percentageLabel = UILabel()
        self.percentageLabel?.frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        self.percentageLabel?.center = CGPoint(x: self.center.x, y: self.center.y)
        self.percentageLabel?.textAlignment = .center
        self.percentageLabel?.textColor = .cyan
        self.addSubview(self.percentageLabel!)
    }

    open func animateCircle(byDuration duration: TimeInterval, andPercentage percentage: Int, withColor color: UIColor) {
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.delegate = self
        let time: CGFloat = 100
        animation.duration = duration
        animation.fromValue = 0
        animation.toValue = time / 100
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.linear)
        self.circleLayer.strokeEnd = time / 100
        self.circleLayer.strokeColor = color.cgColor
        self.circleLayer.add(animation, forKey: "animateCircle")
        
        if self.showPercentageLabel {
            UIView.animate(withDuration: duration/2, animations: {
                self.percentageLabel?.isHidden = true
            }) { (true) in
                self.percentageLabel?.text = "\(percentage)"
                self.percentageLabel?.isHidden = false
            }
        }
    }
    
    public func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        self.circleLayer.removeAllAnimations()
        self.delegate?.animationDidEnd()
    }
}

