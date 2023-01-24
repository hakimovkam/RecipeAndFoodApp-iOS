//
//  TimerProgressBarView.swift
//  galleyRecipe
//
//  Created by Рафия Сафина on 24.01.2023.
//

import UIKit

class TimerProgressBarView: UIView {
    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    
    private var progressColor = UIColor.white {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
        }
    }
    
    private var trackColor = UIColor.white {
        didSet {
            progressLayer.strokeColor = trackColor.cgColor
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createCircularPath()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        createCircularPath()
    }
}

// MARK: - Private funcs
extension TimerProgressBarView {
   private func createCircularPath() {
       self.backgroundColor = .clear
       self.layer.cornerRadius = self.frame.width / 2
       
       let circularPath = UIBezierPath(
        arcCenter: CGPoint(x: frame.size.width / 2.0,y: frame.size.height / 2.0),
        radius: (frame.size.width - 1.5) / 2,
        startAngle: startPoint,
        endAngle: endPoint,
        clockwise: false
       )

       circleLayer.path = circularPath.cgPath
       circleLayer.fillColor = UIColor.clear.cgColor
       circleLayer.strokeColor = trackColor.cgColor
       circleLayer.lineWidth = 20.0
       circleLayer.strokeEnd = 1.0 // значение одного круга
       circleLayer.lineCap = .round
       layer.addSublayer(circleLayer)
           
       progressLayer.path = circularPath.cgPath
       progressLayer.fillColor = UIColor.clear.cgColor
       progressLayer.strokeColor = progressColor.cgColor
       progressLayer.lineWidth = 20.0
       progressLayer.strokeEnd = 0.0
       progressLayer.lineCap = .round
       layer.addSublayer(progressLayer)
   }
    
    func progressAnimation(duration: TimeInterval) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        circularProgressAnimation.duration = duration
        circularProgressAnimation.toValue = 1.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
    }
}
