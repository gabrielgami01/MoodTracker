//
//  HomeVM.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 13/5/25.
//

import SwiftUI

@MainActor
final class HomeVM: ObservableObject {
    let repository: Repository
    
    init(repository: Repository = RepositoryImpl.shared) {
        self.repository = repository
    }
    
    @Published var selectedMood: Mood?

    @Published var selectedDate = Date.now
    var isToday: Bool {
        Calendar.current.isDate(selectedDate, inSameDayAs: .now)
    }
    var isFuture: Bool {
        Calendar.current.startOfDay(for: selectedDate) > Calendar.current.startOfDay(for: .now)
    }
    var actualTimeSlot: TimeSlot {
        TimeSlot.slot(for: .now)
    }
    
    func preloadData() async {
        do {
            try await repository.preloadDefaultReasons()
        } catch {
            print(error.localizedDescription)
        }
    }
}
