//
//  TimeSlot.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 21/5/25.
//

import Foundation

enum TimeSlot: String, CaseIterable, Identifiable {
    case dawn = "Dawn"
    case morning = "Morning"
    case afternoon = "Afternoon"
    case evening = "Evening"
    case night = "Night"
    
    var id: Self { self }
    
    var startHour: Int {
        return switch self {
            case .dawn: 5
            case .morning: 9
            case .afternoon: 13
            case .evening: 17
            case .night: 21
        }
    }

    var endHour: Int {
        return switch self {
            case .dawn: 9
            case .morning: 13
            case .afternoon: 17
            case .evening: 21
            case .night: 5
        }
    }
    
    static func slot(for date: Date, calendar: Calendar = .current) -> TimeSlot {
        return TimeSlot.allCases.first { $0.contains(date, calendar: calendar) }!
    }
    
    func contains(_ date: Date, calendar: Calendar = .current) -> Bool {
        let components = calendar.dateComponents([.hour], from: date)
        guard let hour = components.hour else { return false }
        return hour >= startHour && hour < endHour
    }
}
