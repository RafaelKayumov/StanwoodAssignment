//
//  CreationPeriod.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 02/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

extension RepositoryPlain {

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

        var calendarInterval: Calendar.Component {
            switch self {
            case .day:
                return Calendar.Component.day
            case .month:
                return Calendar.Component.month
            case .year:
                return Calendar.Component.year
            }
        }

        var thresholdDate: Date {
            return Calendar.current.date(byAdding: calendarInterval, value: -1, to: Date())!
        }

        var queryValue: String {
            let dateString = ISO8601DateFormatter().string(from: thresholdDate)
            return "created:>" + dateString
        }
    }
}
