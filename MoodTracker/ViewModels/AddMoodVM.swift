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
    
    @Published var selectedMood: MoodTypes = .neutral
    @Published var selectedEmotions: [Emotions] = []
    @Published var selectedReason: [Reason] = []
    @Published var note = ""
    
    @Published var reasons: [Reason] = []
    
    func fetchReasons() {
        do {
            let result = try repository.fetchReasons()
            reasons = result
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func saveMood() {
        guard let reason = selectedReason.first else { return }
        
        let newMood = Mood(id: UUID(), type: selectedMood, emotions: selectedEmotions, reason: reason, note: note, date: .now)
        do {
            try repository.addMood(newMood)
        }
        catch {
            print(error.localizedDescription)
        }
    }
    
    func selectEmotion(_ emotion: Emotions) {
        guard selectedEmotions.count < 3, !selectedEmotions.contains(emotion) else { return }
        
        selectedEmotions.append(emotion)
    }
    
    func selectReason(_ reason: Reason) {
        selectedReason.removeAll()
        selectedReason.append(reason)
    }
}
