//
//  AddMoodVM.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 9/5/25.
//

import Foundation

@MainActor
final class MoodEditorVM: ObservableObject {
    let repository: Repository
    
    init(repository: Repository = RepositoryImpl.shared, mood: Mood? = nil) {
        self.repository = repository
        self.mood = mood
        fetchReasons()
    }
    
    @Published var mood: Mood?
    
    @Published var selectedMood: MoodTypes = .neutral
    @Published var selectedEmotions: [Emotions] = []
    @Published var selectedReason: [Reason] = []
    @Published var note = ""
    
    @Published var reasons: [Reason] = []
    
    @Published var currentPage = 1
    var isDisabled: Bool {
        if (currentPage == 2 && selectedEmotions.isEmpty) || (currentPage == 3 && selectedReason.isEmpty) {
            true
        } else {
            false
        }
    }
    
    func loadMood() {
        guard let mood else { return }
        
        selectedMood = mood.type
        selectedEmotions = mood.emotions
        selectedReason = [mood.reason]
        note = mood.note
    }
    
    func fetchReasons() {
        do {
            let result = try repository.fetchReasons()
            reasons = result
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func createMood() -> Mood? {
        guard let reason = selectedReason.first else { return nil }
        
        let newMood = Mood(id: mood?.id ?? UUID(), type: selectedMood, emotions: selectedEmotions, reason: reason, note: note, date: .now)
        
        return newMood
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
