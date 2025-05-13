//
//  MoodsVM.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 12/5/25.
//

import Foundation
import SwiftUI

@MainActor
final class MoodsVM: ObservableObject {
    let repository: Repository
    
    init(repository: Repository = RepositoryImpl.shared) {
        self.repository = repository
        fetchMoods()
    }
    
    @Published var moods: [Mood] = []
    
    func fetchMoods() {
        do {
            let result = try repository.fetchMoods()
            moods = result
        } catch {
            print(error.localizedDescription)
        }
    }
}
