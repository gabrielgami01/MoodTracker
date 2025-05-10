//
//  AddMoodVM.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import Foundation

@MainActor
final class AddMoodVM: ObservableObject {
    let repository: Repository
    
    init(repository: Repository = RepositoryImpl.shared) {
        self.repository = repository
        fetchReasons()
    }
    
    @Published var mood: MoodTypes = .neutral
    @Published var emotions: [Emotions] = []
    @Published var reason: Reason?
    
    @Published var reasons: [Reason] = []
    
    func fetchReasons() {
        do {
            let result = try repository.fetchReasons()
            reasons = result
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func selectEmotion(_ emotion: Emotions) {
        guard emotions.count < 3, !emotions.contains(emotion) else { return }
        
        emotions.append(emotion)
    }
}
