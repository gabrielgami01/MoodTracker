//
//  Feeling.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 8/5/25.
//

import SwiftUI

enum MoodTypes: String, CaseIterable, Identifiable {
    case terrible
    case bad
    case neutral
    case good
    case awesome
    
    var id: Self { self }
    
    var imageName: String {
        "\(self.rawValue)_face"
    }
    
    var numericValue: Double {
        switch self {
            case .terrible:
                return 0.2
            case .bad:
                return 0.4
            case .neutral:
                return 0.6
            case .good:
                return 0.8
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
