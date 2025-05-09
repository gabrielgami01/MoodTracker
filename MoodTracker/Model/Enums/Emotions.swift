//
//  Emotions.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 8/5/25.
//

import Foundation

enum Emotions: String, CaseIterable, Identifiable {
    case happy = "Happy"
    case cool = "Cool"
    case peaceful = "Peaceful"
    case surprised = "Surprised"
    case excited = "Excited"
    
    case aww = "Aww"
    case confused = "Confused"
    case stressed = "Stressed"
    case worried = "Worried"
    case angry = "Angry"
    
    static func parseAll(from values: [String]?) -> [Emotions]? {
        guard let values else { return nil }
        
        let mapped = values.compactMap{ Emotions(rawValue: $0) }
        
        return mapped.isEmpty ? nil : mapped
    }
    
    var id: Self { self }
    
    var imageName: String {
        "\(self.rawValue.lowercased())_face"
    }
}
