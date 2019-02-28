//
//  LineView.swift
//
//  Created by Rafael Kayumov on 10.03.16.
//  Copyright (c) 2015 Rafael Kayumov. All rights reserved.
//

import UIKit

@IBDesignable
class LineView: UIView {

    @IBInspectable var color: UIColor! = UIColor.gray

    @IBInspectable var fadeSides: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var fadeSidesInsetBeginning: CGFloat = 0.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var fadeSidesInsetEnding: CGFloat = 0.0 {
        didSet {
            self.setNeedsDisplay()
        }
    }

    @IBInspectable var stickToViewEnding: Bool = false {
        didSet {
            self.setNeedsDisplay()
        }
    }

    func configureFadeSides() {
        self.layer.mask = nil

        if self.fadeSides {
            let gradientLayer = CAGradientLayer()
            gradientLayer.frame = self.layer.bounds
            gradientLayer.colors = [UIColor.white, UIColor.clear]

            var firstPoint: CGFloat
            var secondPoint: CGFloat
            if self.bounds.width >= self.bounds.height {
                firstPoint = self.fadeSidesInsetBeginning / self.bounds.width
                secondPoint = self.fadeSidesInsetEnding / self.bounds.width
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
                gradientLayer.endPoint = CGPoint(x: 1.0, y: 1.0)
            } else {
                firstPoint = self.fadeSidesInsetBeginning / self.bounds.height
                secondPoint = self.fadeSidesInsetEnding / self.bounds.height
                gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
                gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
            }

            let locations = [0, firstPoint, 1 - secondPoint, 1]
            let colors = [UIColor.clear.cgColor, UIColor.white.cgColor, UIColor.white.cgColor, UIColor.clear.cgColor]

            gradientLayer.locations = locations.map { NSNumber(value: Float($0)) }
            gradientLayer.colors = colors

            self.layer.mask = gradientLayer
        }
    }

    override func draw(_ rect: CGRect) {
        super.draw(rect)

        var pointA = CGPoint.zero
        var pointB = CGPoint.zero
        if rect.width >= rect.height {
            let y = stickToViewEnding ? (bounds.size.height) : 0.0
            pointA = CGPoint(x: 0, y: y)
            pointB = CGPoint(x: rect.width, y: y)
        } else {
            let x = stickToViewEnding ? (bounds.size.width - 0.5) : 0.0
            pointA = CGPoint(x: x, y: 0)
            pointB = CGPoint(x: x, y: rect.height)
        }

        if let context = UIGraphicsGetCurrentContext() {
            context.setStrokeColor(color.cgColor)
            context.setLineWidth(0.5)
            context.move(to: pointA)
            context.addLine(to: pointB)
            context.strokePath()
        }

        self.configureFadeSides()
    }
}
