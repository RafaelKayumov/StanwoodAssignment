//
//  CorneredView.swift
//  Races
//
//  Created by Rafael Kayumov on 11.07.2018.
//  Copyright © 2018 Rafael Kayumov. All rights reserved.
//

import UIKit

@IBDesignable
class CorneredButton: UIButton {

    override class var layerClass: AnyClass {
        return CAShapeLayer.self
    }

    var shapeLayer: CAShapeLayer? {
        return layer as? CAShapeLayer
    }

    @IBInspectable var cornerRadius: CGFloat = 0 {
        didSet {
            applyCorners()
        }
    }

    @IBInspectable var color: UIColor = UIColor.clear {
        didSet {
            shapeLayer?.fillColor = color.cgColor
        }
    }

    override func layoutSubviews() {
        super.layoutSubviews()

        applyCorners()
    }

    private func applyCorners() {
        shapeLayer?.path = UIBezierPath(roundedRect: bounds, cornerRadius: cornerRadius).cgPath
    }
}
