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
    }
    
    @Published var mood: MoodTypes = .neutral
}
