//
//  PeriodSelectionView.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 28/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

class PeriodSelectionView: UISegmentedControl {

    func selectCreationPeriod(_ period: ReposLoadingService.CreationPeriod) {
        selectedSegmentIndex = period.rawValue
    }

    var creationPeriod: ReposLoadingService.CreationPeriod {
        guard let periodValue = ReposLoadingService.CreationPeriod(rawValue: selectedSegmentIndex) else {
            fatalError("Segment index doesn't have corresponding period value")
        }
        return periodValue
    }
}
