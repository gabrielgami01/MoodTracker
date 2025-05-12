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
    }
    
    func preloadData() async {
        do {
            try await repository.preloadDefaultReasons()
        } catch {
            print(error.localizedDescription)
        }
    }
}
