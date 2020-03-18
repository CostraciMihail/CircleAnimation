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
    let circleSize = CGSize(width: 300, height: 300)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        circleView = UIView(frame: CGRect(origin: circleOrigin,
                                          size: circleSize))
        
        circleView.backgroundColor = .orange
        view.addSubview(circleView)
        
        configureCircleLayer()
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.startCircleAnimation()
        }
        
//        setUpCircle()
    }
    
    func setUpCircle() {
        
        let shapeLayer = CAShapeLayer()
    
        let path = UIBezierPath(arcCenter: CGPoint(x: circleSize.width/2, y: circleSize.height/2),
                                radius: circleSize.width/2,
                                startAngle: 10.toRadians(),
                                endAngle: 180.toRadians(),
                                clockwise: true)
        
        shapeLayer.path = path.cgPath
        circleView.layer.mask = shapeLayer
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
        
        circleLayer.strokeEnd = 1
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.fromValue = 0
        animation.toValue = 1
        animation.duration = 2.5
        animation.timingFunction = .init(name: .easeInEaseOut)
        circleLayer.add(animation, forKey: nil)
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
