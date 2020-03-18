//
//  ViewController.swift
//  Circle-Completion-Animation
//
//  Created by Mihail Costraci on 3/18/20.
//  Copyright © 2020 FeelIT-Services. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var circleView: UIView!
    let circleOrigin = CGPoint(x: 50, y: 100)
    let circleSize = CGSize(width: 30, height: 30)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleView = UIView(frame: CGRect(origin: circleOrigin,
                                          size: circleSize))
        
        circleView.backgroundColor = .orange
        view.addSubview(circleView)
        
        // Cheia sol animtion
        startCheiaSolAnimation()
        
        // Circle animtion
//        startCircleAnimation()
    }

    
    private var circleLayer = CAShapeLayer()

    private func configureCircleLayer() {
        
        let radius = circleSize.height / 2

        circleLayer.strokeColor = UIColor.black.cgColor
        circleLayer.fillColor = UIColor.clear.cgColor
        circleLayer.lineWidth = radius
        
//        circleView.layer.cornerRadius = circleSize.height/2
//        circleView.layer.masksToBounds = true
        
        circleView.layer.mask = circleLayer
//        circleView.layer.addSublayer(circleLayer)

        let center = CGPoint(x: circleView.bounds.width/2,
                             y: circleView.bounds.height/2)
        let startAngle: CGFloat = -0.25 * 2 * .pi
        let endAngle: CGFloat = startAngle + 2 * .pi
        
        circleLayer.path = UIBezierPath(arcCenter: center,
                                        radius: radius / 2,
                                        startAngle: startAngle,
                                        endAngle: endAngle,
                                        clockwise: true).cgPath

        circleLayer.strokeEnd = 0
    }

    private func startCircleAnimation() {
        
        configureCircleLayer()
        
        circleLayer.strokeEnd = 1
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2.5
        animation.timingFunction = .init(name: .easeInEaseOut)
        circleLayer.add(animation, forKey: nil)
    }

    func startCheiaSolAnimation() {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.cheiaSol()
        }
    }
    
    func cheiaSol() {
        
        //// Bezier Drawing
        let cheiaSolPath = UIBezierPath()
        cheiaSolPath.move(to: CGPoint(x: 103.87, y: 70.21))
        cheiaSolPath.addCurve(to: CGPoint(x: 110.5, y: 59.5), controlPoint1: CGPoint(x: 106.18, y: 70.14), controlPoint2: CGPoint(x: 108.77, y: 61.94))
        cheiaSolPath.addCurve(to: CGPoint(x: 117.5, y: 56.5), controlPoint1: CGPoint(x: 112.52, y: 56.65), controlPoint2: CGPoint(x: 117.5, y: 56.5))
        cheiaSolPath.addLine(to: CGPoint(x: 126.5, y: 59.5))
        cheiaSolPath.addLine(to: CGPoint(x: 132.5, y: 70.21))
        cheiaSolPath.addLine(to: CGPoint(x: 126.5, y: 84.5))
        cheiaSolPath.addLine(to: CGPoint(x: 117.5, y: 92.5))
        cheiaSolPath.addLine(to: CGPoint(x: 103.87, y: 92.5))
        cheiaSolPath.addLine(to: CGPoint(x: 88.5, y: 84.5))
        cheiaSolPath.addLine(to: CGPoint(x: 81.5, y: 72.89))
        cheiaSolPath.addCurve(to: CGPoint(x: 88.5, y: 59.5), controlPoint1: CGPoint(x: 81.5, y: 72.89), controlPoint2: CGPoint(x: 84.26, y: 63.68))
        cheiaSolPath.addCurve(to: CGPoint(x: 129.82, y: 23.85), controlPoint1: CGPoint(x: 102.23, y: 45.99), controlPoint2: CGPoint(x: 131.18, y: 23.85))
        cheiaSolPath.addCurve(to: CGPoint(x: 126.5, y: 9.5), controlPoint1: CGPoint(x: 129.22, y: 23.85), controlPoint2: CGPoint(x: 130.23, y: 15.18))
        cheiaSolPath.addCurve(to: CGPoint(x: 113.5, y: 2.5), controlPoint1: CGPoint(x: 123.49, y: 4.92), controlPoint2: CGPoint(x: 115.88, y: 3.19))
        cheiaSolPath.addCurve(to: CGPoint(x: 104.5, y: 9.5), controlPoint1: CGPoint(x: 109.97, y: 1.48), controlPoint2: CGPoint(x: 104.5, y: 9.5))
        cheiaSolPath.addLine(to: CGPoint(x: 104.5, y: 22.5))
        UIColor.black.setStroke()
        cheiaSolPath.lineWidth = 1
        cheiaSolPath.stroke()


        //// Bezier 2 Drawing
        let bezier2Path = UIBezierPath()
        bezier2Path.move(to: CGPoint(x: 104.5, y: 22.5))
        bezier2Path.addLine(to: CGPoint(x: 104.5, y: 112.5))
        UIColor.black.setStroke()
        bezier2Path.lineWidth = 1
        bezier2Path.stroke()
        
        cheiaSolPath.append(bezier2Path)
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.frame.origin = CGPoint(x: 110.5, y: 59.5)
        shapeLayer.strokeColor = UIColor.orange.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineWidth = 2
        shapeLayer.path = cheiaSolPath.cgPath
        
        view.layer.addSublayer(shapeLayer)
        
        
        let cheiaSolAnimation = CAKeyframeAnimation(keyPath: "position")
        cheiaSolAnimation.isAdditive = true
        cheiaSolAnimation.path = cheiaSolPath.cgPath
        cheiaSolAnimation.duration = 3
        cheiaSolAnimation.calculationMode = CAAnimationCalculationMode(rawValue: "paced")
        
            
        circleView.layer.add(cheiaSolAnimation, forKey: "follow cheia sol")
    }
    
}

extension Int {
    func toRadians() -> CGFloat {
        return CGFloat(self) * CGFloat(Float.pi) / 180.0
    }
}

extension CGFloat {
    func toRadians() -> CGFloat {
        return self * CGFloat(Float.pi) / 180.0
    }
}
