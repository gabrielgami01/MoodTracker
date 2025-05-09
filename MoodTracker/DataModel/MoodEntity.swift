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
              let emotions = Emotions.parseAll(from: emotions),
              let reason = reason?.toReason,
              let note = note,
              let date = date else { return nil}
        
        return Mood(id: id,
                    type: type,
                    emotions: emotions,
                    reason: reason,
                    note: note,
                    date: date)
              
    }
}
