//
//  EllipseView.swift
//
//  Created by Rafael Kayumov on 05.07.2018.

import UIKit

@IBDesignable
class EllipseView: UIView {

    private var borderLayer = CAShapeLayer()

    override func layoutSubviews() {
        super.layoutSubviews()

        roundCorners()
        applyBorder()
    }

    @IBInspectable
    var borderWidth: CGFloat = 0 {
        didSet {
            applyBorder()
        }
    }

    @IBInspectable
    var borderColor: UIColor = UIColor.clear {
        didSet {
            applyBorder()
        }
    }

    private func roundCorners() {
        let layerBounds = layer.bounds
        let radius = min(layerBounds.size.width, layerBounds.size.height) / 2
        let path = UIBezierPath(roundedRect: layerBounds, cornerRadius: radius)
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }

    private func applyBorder() {
        guard let path = (layer.mask as? CAShapeLayer)?.path else { return }
        borderLayer.path = path
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.strokeColor = borderColor.cgColor
        borderLayer.lineWidth = borderWidth
        borderLayer.frame = bounds
        layer.addSublayer(borderLayer)
    }
}
