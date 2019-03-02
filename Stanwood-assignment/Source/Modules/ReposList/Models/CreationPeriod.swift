//
//  CreationPeriod.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 02/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

extension Repository {

    enum CreationPeriod: Int, CaseIterable {
        case day
        case month
        case year

        var title: String {
            switch self {
            case .day:
                return "Day"
            case .month:
                return "Month"
            case .year:
                return "Year"
            }
        }
    }
}
