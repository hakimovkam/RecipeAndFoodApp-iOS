//
//  TimerProgressBarView.swift
//  galleyRecipe
//
//  Created by Рафия Сафина on 24.01.2023.
//

import UIKit

class TimerProgressView: UIView {
    
    private var circleLayer = CAShapeLayer()
    private var progressLayer = CAShapeLayer()
    
    private var startPoint = CGFloat(-Double.pi / 2)
    private var endPoint = CGFloat(3 * Double.pi / 2)
    
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
       
        let circleColor = UIColor.systemGray5.cgColor
    
        circleLayer = createShapeLayer(
            lineWidth: 12.0,
            strokeEnd: 1.0,
            strokeColor: circleColor
        )
       
        progressLayer = createShapeLayer(
            lineWidth: 20.0,
            strokeEnd: 0.8,
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
        
        return CAShapeLayer()
    }
}
