//
//  MoodsVM.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 12/5/25.
//
import SwiftUI

@MainActor
final class MoodStore: ObservableObject {
    let repository: Repository
    
    init(repository: Repository = RepositoryImpl.shared) {
        self.repository = repository
        fetchMoods()
    }
    
    @Published var moods: [Mood] = []
    @Published var reasons: [Reason] = []
    
    func fetchMoods(date: Date = .now) {
        do {
            let result = try repository.fetchMoods(date: date)
            moods = result
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addMood(_ mood: Mood) {
        do {
            try repository.addMood(mood)
            fetchMoods()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func deleteMood(_ mood: Mood?) {
        guard let mood else { return }
        
        do {
            try repository.deleteMood(mood)
            fetchMoods()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func updateMood(_ mood: Mood) {
        do {
            try repository.updateMood(mood)
            fetchMoods()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func fetchReasons() {
        do {
            let result = try repository.fetchReasons()
            reasons = result
        } catch {
            print(error.localizedDescription)
        }
    }
    
    func addReason(_ reason: Reason) {
        do {
            try repository.addReason(reason)
            fetchReasons()
        } catch {
            print(error.localizedDescription)
        }
    }
}
