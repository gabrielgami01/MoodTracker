//
//  Mood.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import Foundation

struct Mood {
    let id: UUID
    let type: MoodTypes
    let emotions: [Emotions]
    let reason: Reason
    let note: String
    let date: Date
}
