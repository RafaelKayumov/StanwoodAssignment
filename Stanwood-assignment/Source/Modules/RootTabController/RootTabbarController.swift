//
//  RootTabbarController.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 28/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import UIKit

private let kSegmentedControlSidePadding: CGFloat = 15

class RootTabbarController: UITabBarController {

    private weak var creationPeriodSelectionView: PeriodSelectionView!
    weak var output: RootTabControllerViewOutput!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCreationPeriodSelectionView()
    }
}

extension RootTabbarController: RootTabControllerViewInput {
    func selectPeriod(_ period: Repository.CreationPeriod) {
        creationPeriodSelectionView.selectCreationPeriod(period)
    }
}

private extension RootTabbarController {

    func setupCreationPeriodSelectionView() {
        creationPeriodSelectionView = PeriodSelectionView.loadFromNib()
        creationPeriodSelectionView.configureSegmentsSet(with: Repository.CreationPeriod.allCases)
        creationPeriodSelectionView.addTarget(self, action: #selector(onSegmentSelection(sender:)), for: .valueChanged)
        let newFrame = CGRect(x: 0, y: 0, width: view.bounds.width - 2 * kSegmentedControlSidePadding, height: creationPeriodSelectionView.frame.height)
        creationPeriodSelectionView.frame = newFrame
        navigationItem.titleView = creationPeriodSelectionView
    }

    @objc private func onSegmentSelection(sender: PeriodSelectionView) {
        output.onPeriodSelection(period: sender.creationPeriod)
    }
}
