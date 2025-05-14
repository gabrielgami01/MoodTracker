//
//  File.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 14/5/25.
//

import Foundation

extension Date {
    static func currentWeekDates(calendar: Calendar = Calendar(identifier: .iso8601)) -> [Date] {
        // Obtenemos el intervalo de la semana ISO (lunes–domingo)
        guard let weekInterval = calendar.dateInterval(of: .weekOfYear, for: Date()) else {
            return []
        }
        // Generamos los 7 días empezando por weekInterval.start (lunes)
        return (0..<7).compactMap { offset in
            calendar.date(byAdding: .day, value: offset, to: weekInterval.start)
        }
    }
}
