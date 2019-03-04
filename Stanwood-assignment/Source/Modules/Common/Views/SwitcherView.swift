//
//  SwitcherView.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 28/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import UIKit

@objc protocol SwitcherImageViewDelegate: class {
    func onSwitcherImageView(_ switcherImageView: SwitcherImageView, enabled: Bool)
}

class SwitcherImageView: UIImageView {

    @IBInspectable var enabledStateImage: UIImage?
    @IBInspectable var disabledStateImage: UIImage?
    @IBOutlet weak var delegate: SwitcherImageViewDelegate?

    var stateEnabled = false {
        didSet {
            setupImageForCurrentSate()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        setupGesture()
        setupImageForCurrentSate()
    }

    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(onTap))
        self.addGestureRecognizer(tapGesture)
    }

    private func setupImageForCurrentSate() {
        if stateEnabled {
            image = enabledStateImage
        } else {
            image = disabledStateImage
        }
    }

    private func switchState() {
        stateEnabled = !stateEnabled
        delegate?.onSwitcherImageView(self, enabled: stateEnabled)
    }

    @objc private func onTap() {
        switchState()
    }
}
