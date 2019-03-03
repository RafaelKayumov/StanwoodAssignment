//
//  PeriodSelectionView.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 28/02/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

class PeriodSelectionView: UISegmentedControl {

    func configureSegmentsSet(with periods: [RepositoryPlain.CreationPeriod]) {
        removeAllSegments()
        periods.forEach { element in
            insertSegment(withTitle: element.title.capitalized, at: element.rawValue, animated: false)
        }
    }

    func selectCreationPeriod(_ period: RepositoryPlain.CreationPeriod) {
        selectedSegmentIndex = period.rawValue
    }

    var creationPeriod: RepositoryPlain.CreationPeriod {
        guard let periodValue = RepositoryPlain.CreationPeriod(rawValue: selectedSegmentIndex) else {
            fatalError("Segment index doesn't have corresponding period value")
        }
        return periodValue
    }
}
