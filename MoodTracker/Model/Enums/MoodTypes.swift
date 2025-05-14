//
//  Feeling.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 8/5/25.
//

import SwiftUI

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
    
    var numericValue: Double {
        switch self {
            case .terrible:
                return 0.1
            case .bad:
                return 0.25
            case .neutral:
                return 0.5
            case .good:
                return 0.75
            case .awesome:
                return 1
        }
    }
    
    var color: Color {
        switch self {
            case .terrible:
                return .red
            case .bad:
                return .orange
            case .neutral:
                return .yellow
            case .good:
                return .blue
            case .awesome:
                return .green
        }
    }
}
