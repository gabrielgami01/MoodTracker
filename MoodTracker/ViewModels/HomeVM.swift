//
//  HomeVM.swift
//  MoodTracker
//
//  Created by Gabriel Garcia Millan on 13/5/25.
//

import SwiftUI

final class HomeVM: ObservableObject {
    let repository: Repository
    
    init(repository: Repository = RepositoryImpl.shared) {
        self.repository = repository
    }
    
    func preloadData() async {
        do {
            try await repository.preloadDefaultReasons()
        } catch {
            print(error.localizedDescription)
        }
    }
}
