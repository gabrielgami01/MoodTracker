//
//  Reason.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import Foundation

struct Reason: Identifiable, Hashable, Decodable {
    let id: UUID
    let name: String
}
