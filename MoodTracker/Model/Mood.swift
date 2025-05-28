//
//  Mood.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import Foundation

struct Mood: Identifiable {
    let id: UUID
    let type: MoodTypes
    let emotions: [Emotions]
    let reason: Reason
    let note: String
    let timeSlot: TimeSlot
    let date: Date
    
    var emotionsList: String {
        emotions
            .map { NSLocalizedString($0.rawValue, comment: "") }
            .formatted(.list(type: .and))
    }
}
