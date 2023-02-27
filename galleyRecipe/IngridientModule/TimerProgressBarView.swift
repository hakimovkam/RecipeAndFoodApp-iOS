//
//  TimerProgressBarView.swift
//  galleyRecipe
//
//  Created by Рафия Сафина on 24.01.2023.
//

import UIKit

final class TimerProgressView: UIView {
    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    
    private var isAnimationStarted = false
    
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
            strokeColor: UIColor.customLightGray.cgColor)
        progressLayer = createShapeLayer(
            lineWidth: 20.0,
            strokeColor: UIColor.customGreen.cgColor)
    }
    
    private func createShapeLayer(lineWidth: CGFloat, strokeColor: CGColor) -> CAShapeLayer {
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
        shapeLayer.strokeEnd = 1.0
        shapeLayer.lineCap = .round
        layer.addSublayer(shapeLayer)
        
        return shapeLayer
    }
    
    func startAnimation(currentStep: Int, totalSteps: Int) {
        let circularProgressAnimation = CABasicAnimation(keyPath: "strokeEnd")
        let newProgress = 1.0 - Double(currentStep) / Double(totalSteps)
        circularProgressAnimation.fromValue = progressLayer.strokeEnd
        circularProgressAnimation.toValue = newProgress
        progressLayer.strokeEnd = newProgress
        progressLayer.add(circularProgressAnimation, forKey: "progressAnim")
        isAnimationStarted = true
    }
    
    func changeStrokeColor(currentStep: Int, totalSteps: Int) {
        let threeQuarter = totalSteps / 4 * 3
        if currentStep <= threeQuarter {
            progressLayer.strokeColor = UIColor.customGreen.cgColor
        } else {
            progressLayer.strokeColor =
            UIColor.customRed.cgColor
        }
    }
    
    func resetAnimation() {
        progressLayer.beginTime = 0.0
        progressLayer.strokeEnd = 1.0
        progressLayer.strokeColor = UIColor.customGreen.cgColor
        progressLayer.removeAllAnimations()
        isAnimationStarted = false
    }
    
    func removeProgressStroke() {
        progressLayer.strokeColor = UIColor.clear.cgColor
    }
   
    func resumeAnimation() {
        let pausedTime = progressLayer.timeOffset
        let timeSincePaused = progressLayer.convertTime(CACurrentMediaTime(), from: nil) - pausedTime
        progressLayer.beginTime = timeSincePaused
    }
    
    func pauseAnimation() {
        let pausedTime = progressLayer.convertTime(CACurrentMediaTime(), from: nil)
        progressLayer.timeOffset = pausedTime
        progressLayer.strokeColor = UIColor.customGray.cgColor
    }
}
