//
//  Feeling.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 8/5/25.
//

import Foundation

enum MoodTypes: String, CaseIterable, Identifiable {
    case terrible = "Terrible"
    case bad = "Bad"
    case neutral = "Neutral"
    case good = "Good"
    case awesome = "Awesome"
    
    var id: Self { self }
    
    var imageName: String {
        "\(self.rawValue.lowercased())_face"
    }
}
