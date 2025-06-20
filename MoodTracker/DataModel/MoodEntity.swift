//
//  MoodEntity.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import Foundation
import CoreData

extension MoodEntity {
    var toMood: Mood? {
        guard let id,
              let rawType = type, let type = MoodTypes(rawValue: rawType),
              let emotions = Emotions.parseAll(from: emotions as? [String]),
              let reason = reason?.toReason,
              let note = note,
              let rawSlot = slot, let timeSlot = TimeSlot(rawValue: rawSlot),
              let date = date else { return nil}
        
        return Mood(id: id,
                    type: type,
                    emotions: emotions,
                    reason: reason,
                    note: note,
                    timeSlot: timeSlot,
                    date: date)
              
    }
}
