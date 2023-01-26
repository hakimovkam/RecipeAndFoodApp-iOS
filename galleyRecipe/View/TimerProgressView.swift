//
//  TimerProgressBarView.swift
//  galleyRecipe
//
//  Created by Рафия Сафина on 24.01.2023.
//

import UIKit

class TimerProgressView: UIView, CAAnimationDelegate {
    
    private var secondsRemain = 5

    private let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(2 * Double.pi)
    
    private var isAnimationStarted = false
    
    var progressColor = UIColor.white {
        didSet {
            progressLayer.strokeColor = progressColor.cgColor
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
extension TimerProgressView {
    
    private func createCircularPath() {
        self.backgroundColor = .clear
        self.layer.cornerRadius = self.frame.width / 2
       
        circleLayer = createShapeLayer(
            lineWidth: 12.0,
            strokeEnd: 1.0,
            strokeColor: UIColor.systemGray5.cgColor
        )
       
        progressLayer = createShapeLayer(
            lineWidth: 20.0,
            strokeEnd: 1.0,
            strokeColor: progressColor.cgColor
        )
    }
    
    private func createShapeLayer(lineWidth: CGFloat, strokeEnd: CGFloat, strokeColor: CGColor) -> CAShapeLayer {
        let startPoint = CGFloat(-Double.pi / 2)
        let endPoint = CGFloat(3 * Double.pi / 2)
        
        let shapeLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(
            arcCenter: CGPoint(x: frame.size.width / 2.0, y: frame.size.height / 2.0),
            radius: (frame.size.width - 1.5) / 2,
            startAngle: startPoint,
            endAngle: endPoint,
            clockwise: true
        )

        shapeLayer.path = circularPath.cgPath
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = strokeColor
        shapeLayer.lineWidth = lineWidth
        shapeLayer.strokeEnd = strokeEnd
        shapeLayer.lineCap = .round
        layer.addSublayer(shapeLayer)
        
        return shapeLayer
    }
    
    func startResumeAnimation() {
        if !isAnimationStarted {
            startAnimation(duration: TimeInterval(secondsRemain))
        } else {
            resumeAnimation()
        }
    }
    
     func startAnimation(duration: TimeInterval) {
        resetAnimation()
         progressLayer.strokeEnd = 0.0
        circularProgressAnimation.duration = duration
         circularProgressAnimation.delegate =  self
         circularProgressAnimation.fromValue = 1.0
        circularProgressAnimation.toValue = 0.0
        circularProgressAnimation.fillMode = .forwards
        circularProgressAnimation.isRemovedOnCompletion = false
         circularProgressAnimation.isAdditive = true
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        isAnimationStarted = true
    }
    
    func resetAnimation() {
        progressLayer.speed = 1.0
        progressLayer.timeOffset = 0.0
        progressLayer.beginTime = 0.0
        progressLayer.strokeEnd = 0.0
//        progressLayer.removeAllAnimations()
        isAnimationStarted = false
    }
    
    func resumeAnimation() {
        let pausedTime = progressLayer.timeOffset
        progressLayer.speed = 1.0
        progressLayer.timeOffset = 0.0
        progressLayer.beginTime = 0.0
        let timeSincePaused = progressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        progressLayer.beginTime = timeSincePaused
    }
    
    func pauseAnimation() {
        let pausedTime = progressLayer.convertTime(CACurrentMediaTime(), from: nil)
        progressLayer.speed = 0.0
        progressLayer.timeOffset = pausedTime
    }
    
    func stopAnimation() {
        progressLayer.speed = 1.0
        progressLayer.timeOffset = 0.0
        progressLayer.beginTime = 0.0
        progressLayer.strokeEnd = 1.0
        progressLayer.removeAllAnimations()
        isAnimationStarted = false
    }
    
    internal func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
        stopAnimation()
    }
}
