//
//  Date+Format.swift
//  Stanwood-assignment
//
//  Created by Rafael Kayumov on 04/03/2019.
//  Copyright © 2019 Rafael Kayumov. All rights reserved.
//

import Foundation

extension Date {

    func asString(template: String) -> String {
        let format = DateFormatter.dateFormat(fromTemplate: template, options: 0, locale: NSLocale.current)
        let formatter = DateFormatter()
        formatter.dateFormat = format

        return formatter.string(from: self)
    }

    var compactString: String {
        return asString(template: "MM/dd/yy")
    }
}

extension Date {

    func timeAgoDisplay() -> String {
        let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: self, to: Date())

        if let year = interval.year, year > 0 {
            return year == 1 ? "\(year)" + " " + "year" :
                "\(year)" + " " + "years"
        } else if let month = interval.month, month > 0 {
            return month == 1 ? "\(month)" + " " + "month" :
                "\(month)" + " " + "months"
        } else if let day = interval.day, day > 0 {
            return day == 1 ? "\(day)" + " " + "day" :
                "\(day)" + " " + "days"
        } else if let hour = interval.hour, hour > 0 {
            return hour == 1 ? "\(hour)" + " " + "hour" :
                "\(hour)" + " " + "hours"
        } else if let minute = interval.minute, minute > 0 {
            return minute == 1 ? "\(minute)" + " " + "minute" :
                "\(minute)" + " " + "minutes"
        } else if let second = interval.second, second > 0 {
            return second == 1 ? "\(second)" + " " + "second" :
                "\(second)" + " " + "seconds"
        } else {
            return "a moment"
        }
    }
}
