//
//  Circular.swift
//  PieChartTest
//
//  Created by Kaue Ludovico on 27/05/24.
//

import SwiftUI

open class Circular: UIView {
    // MARK: - Public Properties
    public var animationType: AnimationStyle {
        get {
            return _animationType
        }
        set(newValue) {
            _animationType = newValue
            setNeedsDisplay()
        }
    }
    
    public var lineWidth: CGFloat {
        get {
            return _lineWidth
        }
        set(newValue) {
            _lineWidth = newValue
            setNeedsDisplay()
        }
    }
    
    //  MARK:- Private Variable
    
    private var _percentages: [Double]
    private var _colors: [UIColor]
    private var _lineWidth = CGFloat(10.0)
    private var _animationType: AnimationStyle
    
    //MARK:- Initialization
    public init(percentages: [Double], colors: [UIColor], animationType: AnimationStyle = .animationFanAll) {
        self._percentages = percentages
        self._colors = colors
        self._animationType = animationType
        super.init(frame: CGRect.zero)
        self.backgroundColor = .clear
        self.clipsToBounds = false
    }
    
    required public init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- draw
    override public func draw(_ rect: CGRect) {
        var startAngle = -90.0
        
        for i in 0..<_percentages.count {
            let endAngle = startAngle + (_percentages[i] * 3.6) + 1
            let shapeLayer = self.addArc(with: _colors[i], in: rect, startAngle: startAngle, endAngle: endAngle)
            showAnimationStyle(index: Double(i), shapeLayer: shapeLayer, startAngle: startAngle, endAngle: endAngle)
            showPercentages(midAngel: startAngle + (endAngle - startAngle)/2, percentage: _percentages[i])
            startAngle = (endAngle - 1)
        }
    }
    
    //MARK:- Animations Functions
    private func showAnimationStyle(index: Double, shapeLayer: CAShapeLayer, startAngle: Double, endAngle: Double) {
        switch _animationType {
        case .animationFanAll:
            maskEachLayerAnimation(startAngal: startAngle, endAngal: endAngle + 4, shape: shapeLayer)
        case .animationFan:
            if Int(index) == _percentages.count - 1 {
                maskAnimation()
            }
        case .animationFadeIn:
            oppacityAnimation(index: index, shape: shapeLayer)
        case .animationthreeD:
            transformAnimation(index: index, shape: shapeLayer)
        case .none:
            break
        }
    }
    
    private  func oppacityAnimation(index: Double, shape: CAShapeLayer) {
        shape.opacity = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(index)/2.5 ) {
            shape.opacity = 1
            let animation = CABasicAnimation(keyPath: "opacity")
            animation.fromValue = 0
            animation.toValue = 1
            animation.duration = 1
            shape.add(animation, forKey: nil)
        }
    }
    
    private func transformAnimation(index: Double, shape: CAShapeLayer) {
        shape.opacity = 0
        DispatchQueue.main.asyncAfter(deadline: .now() + Double(index)/2.5 ) {
            shape.opacity = 1
            let animation = CABasicAnimation(keyPath: "transform")
            animation.fromValue = CATransform3DMakeScale(0, 0, 1)
            animation.toValue = CATransform3DIdentity
            animation.duration = 1
            shape.add(animation, forKey: nil)
        }
    }
    
    private func maskEachLayerAnimation(startAngal: Double, endAngal: Double, shape: CAShapeLayer) {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.green.cgColor
        shapeLayer.lineWidth = max(bounds.maxX, bounds.maxY) / 5
        shapeLayer.frame = bounds
        let center = CGPoint(x: bounds.midX, y: bounds.midY)
        let longestSide = max(bounds.height, bounds.width)
        shapeLayer.path = UIBezierPath(arcCenter: center, radius: longestSide/2, startAngle: CGFloat(startAngal).deg2rad(), endAngle: CGFloat(endAngal).deg2rad(), clockwise: true).cgPath
        shapeLayer.strokeEnd = 0
        shape.mask = shapeLayer
        
        addAnimationToLayer(toLayer: shape, fromLayer: shapeLayer)
    }
    
    private func maskAnimation() {
        let shapeLayer = CAShapeLayer()
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.strokeColor = UIColor.white.cgColor
        shapeLayer.lineWidth = max(bounds.maxX, bounds.maxY) / 2
        shapeLayer.frame = bounds
        let path = UIBezierPath(arcCenter: CGPoint(x:bounds.midX,y:bounds.midY), radius:max( bounds.maxX/2,bounds.maxY/2), startAngle: CGFloat(-89.0).deg2rad(), endAngle: CGFloat(270.0).deg2rad(), clockwise: true)
        
        shapeLayer.path = path.cgPath
        shapeLayer.strokeEnd = 0
        self.layer.mask = shapeLayer
        
        addAnimationToLayer(toLayer: self.layer, fromLayer: shapeLayer)
    }
    
    private func addAnimationToLayer(toLayer: CALayer, fromLayer: CAShapeLayer) {
        CATransaction.begin()
        CATransaction.setCompletionBlock {
            toLayer.mask = nil
        }
        
        let animation = CABasicAnimation(keyPath: "strokeEnd")
        animation.beginTime = CACurrentMediaTime() + 0.3
        animation.fromValue = 0
        animation.toValue = 1
        animation.fillMode = .forwards
        animation.isRemovedOnCompletion = false
        animation.duration = 1
        fromLayer.add(animation, forKey: "line")
        
        CATransaction.commit()
    }
    
    //MARK:- show percentages
    private func showPercentages(midAngel: Double, percentage: Double) {
        
        var infoChartView  = InfoChart()
        infoChartView = InfoChart(frame: self.frame)
        infoChartView.setupInfos(percentage: doubleFormatter(percentage), weekDay: "Segunda-feira", date: "27.05.2024")
        
        infoChartView.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(infoChartView)
        
        NSLayoutConstraint.activate([
            infoChartView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            infoChartView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            infoChartView.widthAnchor.constraint(equalToConstant: 180),
            infoChartView.heightAnchor.constraint(equalToConstant: 180)
        ])
        
        
//
//        var delay = 1.5
//        if self.animationType == .none {
//            delay = 0
//        }
//        
//        UIView.animate(withDuration: 0.5, delay: delay, options: .curveEaseOut, animations: {
        infoChartView.alpha = 1
//        })
    }
    
    //MARK:- Drawing Code
    private func addArc(with color: UIColor, in rect: CGRect, startAngle: Double, endAngle: Double) -> CAShapeLayer {
        let center = CGPoint(x: rect.maxX / 2, y: rect.maxY / 2)
        let longestSide = max(rect.height, rect.width)
        let lineWidth = CGFloat(self._lineWidth / 20)
        let smallCircleRadious = (longestSide / (2 + lineWidth))
        let startAngle = CGFloat(startAngle)
        let endAngle = CGFloat(endAngle)
        let outerRadious =  (longestSide / 2)
        let midPoint = (longestSide / (2 + lineWidth/2.7))
        let path = UIBezierPath()
        let  x3 = center.x  + (outerRadious) * CGFloat(cos(startAngle.deg2rad()))
        let  y3 = center.y  + (outerRadious) * CGFloat(sin(startAngle.deg2rad()))
        let  x4 = center.x  + (smallCircleRadious) * CGFloat(cos(startAngle.deg2rad()))
        let  y4 = center.y  + (smallCircleRadious) * CGFloat(sin(startAngle.deg2rad()))
        let  x5 = center.x  + (midPoint) * CGFloat(cos((startAngle + self._lineWidth * 0.5).deg2rad()))
        let  y5 = center.y  + (midPoint) * CGFloat(sin((startAngle +  self._lineWidth * 0.5).deg2rad()))
        path.move(to: CGPoint(x: x4, y: y4))
        path.addQuadCurve(to: CGPoint(x: x3, y: y3), controlPoint: CGPoint(x: x5, y: y5))
        path.addArc(withCenter: center, radius: outerRadious, startAngle: startAngle.deg2rad(), endAngle: endAngle.deg2rad(), clockwise: true)
        let  x1 = center.x  + (outerRadious) * CGFloat(cos(endAngle.deg2rad()))
        let  y1 = center.y  + (outerRadious) * CGFloat(sin(endAngle.deg2rad()))
        let  x6 = center.x  + (midPoint) * CGFloat(cos((endAngle + self._lineWidth * 0.6).deg2rad()))
        let  y6 = center.y  + (midPoint) * CGFloat(sin((endAngle + self._lineWidth * 0.6).deg2rad()))
        let  x2 = center.x  + (smallCircleRadious) * CGFloat(cos(endAngle.deg2rad()))
        let  y2 = center.y  + (smallCircleRadious) * CGFloat(sin(endAngle.deg2rad()))
        path.move(to: CGPoint(x: x1, y: y1))
        path.addQuadCurve(to: CGPoint(x: x2, y: y2), controlPoint: CGPoint(x: x6, y: y6))
        path.addArc(withCenter: center, radius: smallCircleRadious, startAngle:  endAngle.deg2rad(), endAngle: startAngle.deg2rad(), clockwise: false)
        let shape = CAShapeLayer()
        shape.frame = bounds
        shape.lineCap = .round
        shape.fillColor = color.cgColor
        shape.path = path.cgPath
        layer.addSublayer(shape)
        return shape
    }
    
    func doubleFormatter(_ valor: Double) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 0
        formatter.maximumFractionDigits = 0
        return "\(String(describing: formatter.string(from: NSNumber(value: valor))!))%"
    }
}





extension CGFloat {
    func deg2rad() -> CGFloat {
        return self * .pi / 180
    }
}
