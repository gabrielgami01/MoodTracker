//
//  MockData.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import Foundation

extension Mood {
    static let mocks: [Mood] = [.mock1, .mock2, .mock3, .mock4, .mock5]
    
    static let mock1 = Mood(id: UUID(),
                            type: .awesome,
                            emotions: [.peaceful, .happy],
                            reason: .mock1,
                            note: "Nice 8 hours of sleep!",
                            timeSlot: .dawn,
                            date: Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: Date.now),
                                                                             month: Calendar.current.component(.month, from: Date.now),
                                                                             day: Calendar.current.component(.day, from: Date.now),
                                                                             hour: 07,
                                                                             minute: 15))!
    )
    static let mock2 = Mood(id: UUID(),
                            type: .neutral,
                            emotions: [.peaceful],
                            reason: .mock2,
                            note: "Normal day of work",
                            timeSlot: .morning,
                            date: Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: Date.now),
                                                                             month: Calendar.current.component(.month, from: Date.now),
                                                                             day: Calendar.current.component(.day, from: Date.now),
                                                                             hour: 11,
                                                                             minute: 00))!
    )
    static let mock3 = Mood(id: UUID(),
                            type: .terrible,
                            emotions: [.worried, .aww],
                            reason: .mock3,
                            note: "Big headache",
                            timeSlot: .afternoon,
                            date: Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: Date.now),
                                                                             month: Calendar.current.component(.month, from: Date.now),
                                                                             day: Calendar.current.component(.day, from: Date.now),
                                                                             hour: 15,
                                                                             minute: 30))!
    )
    static let mock4 = Mood(id: UUID(),
                            type: .good,
                            emotions: [.cool],
                            reason: .mock4,
                            note: "Nice day at the gym",
                            timeSlot: .evening,
                            date: Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: Date.now),
                                                                             month: Calendar.current.component(.month, from: Date.now),
                                                                             day: Calendar.current.component(.day, from: Date.now),
                                                                             hour: 20,
                                                                             minute: 00))!
    )
    static let mock5 = Mood(id: UUID(),
                            type: .bad,
                            emotions: [.angry],
                            reason: .mock5,
                            note: "Football team loss",
                            timeSlot: .night,
                            date: Calendar.current.date(from: DateComponents(year: Calendar.current.component(.year, from: Date.now),
                                                                             month: Calendar.current.component(.month, from: Date.now),
                                                                             day: Calendar.current.component(.day, from: Date.now),
                                                                             hour: 23,
                                                                             minute: 30))!
    )
}

extension Reason {
    static let mocks: [Reason] = [.mock1, .mock2, .mock3]
    
    static let mock1 = Reason(id: UUID(),
                              name: "Sleep")
    static let mock2 = Reason(id: UUID(),
                              name: "Work")
    static let mock3 = Reason(id: UUID(),
                              name: "Health")
    static let mock4 = Reason(id: UUID(),
                              name: "Hobbies")
    static let mock5 = Reason(id: UUID(),
                              name: "Sports")
}
