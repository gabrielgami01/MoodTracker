//
//  Emotions.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 8/5/25.
//

import Foundation

enum Emotions: String, CaseIterable, Identifiable {
    case happy
    case cool
    case peaceful
    case surprised
    case excited
    
    case aww
    case confused
    case stressed
    case worried
    case angry
    
    static func parseAll(from values: [String]?) -> [Emotions]? {
        guard let values else { return nil }
        
        let mapped = values.compactMap{ Emotions(rawValue: $0) }
        
        return mapped.isEmpty ? nil : mapped
    }
    
    var id: Self { self }
    
    var imageName: String {
        "\(self.rawValue)_face"
    }
}
