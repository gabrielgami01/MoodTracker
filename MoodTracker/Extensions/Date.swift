//
//  File.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 14/5/25.
//

import Foundation

extension Date {
    static func weekDates(containing date: Date, calendar: Calendar = Calendar(identifier: .iso8601)) -> [Date] {
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: date) else { return [] }
        return (0..<7).compactMap {
            calendar.date(byAdding: .day, value: $0, to: weekInterval.start)
        }
    }
}
