//
//  DateUtils.swift
//  YumemiTutorial
//
//  Created by Apple on 2023/06/17.
//

import UIKit

class DateUtils: NSObject {
    class func dateFromString(string: String, format: String, locale: Locale) -> Date {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        formatter.locale = locale
        return formatter.date(from: string)!
    }

    class func stringFromDate(date: Date, format: String, locale: Locale) -> String {
        let formatter: DateFormatter = DateFormatter()
        formatter.calendar = Calendar(identifier: .gregorian)
        formatter.dateFormat = format
        formatter.locale = locale
        return formatter.string(from: date)
    }
}
