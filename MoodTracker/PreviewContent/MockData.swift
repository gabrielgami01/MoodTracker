//
//  MockData.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import Foundation

extension Mood {
    static let mock1 = Mood(id: UUID(),
                            type: .good,
                            emotions: [.peaceful, .happy],
                            reason: .mock1,
                            note: "Nice 8 hours of sleep!",
                            date: Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: Date.now),
                                                                             month: Calendar.current.component(.month, from: Date.now),
                                                                             day: Calendar.current.component(.day, from: Date.now),
                                                                             hour: 09,
                                                                             minute: 00))!
    )
    static let mock2 = Mood(id: UUID(),
                            type: .neutral,
                            emotions: [.peaceful],
                            reason: .mock1,
                            note: "Normal day of work",
                            date: Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: Date.now),
                                                                             month: Calendar.current.component(.month, from: Date.now),
                                                                             day: Calendar.current.component(.day, from: Date.now),
                                                                             hour: 16,
                                                                             minute: 00))!
    )
    static let mock3 = Mood(id: UUID(),
                            type: .terrible,
                            emotions: [.worried, .aww],
                            reason: .mock1,
                            note: "Big headache",
                            date: Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: Date.now),
                                                                             month: Calendar.current.component(.month, from: Date.now),
                                                                             day: Calendar.current.component(.day, from: Date.now),
                                                                             hour: 21,
                                                                             minute: 15))!
    )
}

extension Reason {
    static let mock1 = Reason(id: UUID(),
                              name: "Sleep")
    static let mock2 = Reason(id: UUID(),
                              name: "Work")
    static let mock3 = Reason(id: UUID(),
                              name: "Health")
}
